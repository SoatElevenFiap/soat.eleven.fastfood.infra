# Network Security Group para APIM
resource "azurerm_network_security_group" "apim_nsg" {
  name                = "${var.apim_name}-nsg"
  location           = var.location
  resource_group_name = var.resource_group_name

  # Regra para HTTPS inbound (443)
  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Regra para HTTP inbound (80)
  security_rule {
    name                       = "AllowHTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Regra para APIM Management (3443)
  security_rule {
    name                       = "AllowAPIMManagement"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3443"
    source_address_prefix      = "ApiManagement"
    destination_address_prefix = "VirtualNetwork"
  }

  # Regra para Azure Load Balancer
  security_rule {
    name                       = "AllowAzureLoadBalancer"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# Associar NSG à subnet do APIM
resource "azurerm_subnet_network_security_group_association" "apim_nsg_association" {
  subnet_id                 = var.apim_subnet_id
  network_security_group_id = azurerm_network_security_group.apim_nsg.id
}

# Azure API Management - Configuração Econômica para Estudantes
resource "azurerm_api_management" "main" {
  name                = var.apim_name
  location           = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email

  # SKU Developer para economia - suporte limitado mas funcional
  sku_name = var.sku_name

  # Configuração de rede para permitir integração com Ingress
  # Usando External para ter IP público e permitir acesso do ingress
  virtual_network_type = "External"
  virtual_network_configuration {
    subnet_id = var.apim_subnet_id
  }

  # Configurações básicas
  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

  # Dependência do NSG
  depends_on = [azurerm_subnet_network_security_group_association.apim_nsg_association]
}