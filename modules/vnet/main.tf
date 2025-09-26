# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  tags = merge(var.tags, {
    Type      = "Virtual Network"
    CreatedBy = "Terraform Module"
  })
}

# Subnet de aplicações
resource "azurerm_subnet" "app_subnet" {
  name                 = "${var.vnet_name}-app-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.app_subnet_prefixes

  # Delegação de container apenas se habilitada
  dynamic "delegation" {
    for_each = var.enable_container_delegation ? [1] : []
    content {
      name = "container-delegation"
      service_delegation {
        name    = "Microsoft.ContainerInstance/containerGroups"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }
  }
}

# Subnet de banco de dados
resource "azurerm_subnet" "db_subnet" {
  name                 = "${var.vnet_name}-db-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.db_subnet_prefixes
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}

# Application Gateway Subnet
resource "azurerm_subnet" "app_gateway_subnet" {
  name                 = "${var.vnet_name}-appgw-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.app_gateway_subnet_prefixes
}

# Gateway Subnet (para VPN/ExpressRoute - opcional)
resource "azurerm_subnet" "gateway_subnet" {
  count                = var.create_gateway_subnet ? 1 : 0
  name                 = "GatewaySubnet"  # Nome fixo requerido pelo Azure
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.gateway_subnet_prefixes
}

# Network Security Group essencial apenas para banco de dados
resource "azurerm_network_security_group" "db_nsg" {
  name                = "${var.vnet_name}-db-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Permitir PostgreSQL da subnet de aplicação
  security_rule {
    name                       = "Allow-PostgreSQL-from-App"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefixes    = var.app_subnet_prefixes
    destination_address_prefix = "*"
  }

  # Negar todo o resto
  security_rule {
    name                       = "Deny-All-Inbound"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = merge(var.tags, {
    Type    = "Network Security Group"
    Purpose = "Database Subnet"
  })
}

# Associação do NSG apenas com subnet de banco
resource "azurerm_subnet_network_security_group_association" "db_nsg_association" {
  subnet_id                 = azurerm_subnet.db_subnet.id
  network_security_group_id = azurerm_network_security_group.db_nsg.id
}