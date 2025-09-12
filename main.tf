# Create a resource group
resource "azurerm_resource_group" "rg-postech" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

resource "azurerm_storage_account" "tfstate" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg-postech.name
  location                 = azurerm_resource_group.rg-postech.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = "dev"
    Project     = "FastFood-System"
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = var.terraform_storage_container_name
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

# Virtual Network Module
module "vnet" {
  source = "./modules/vnet"

  # Configuração obrigatória
  vnet_name           = var.vnet_name
  resource_group_name = azurerm_resource_group.rg-postech.name
  location           = azurerm_resource_group.rg-postech.location

  # Configuração de rede
  address_space              = var.vnet_address_space
  app_subnet_prefixes        = var.app_subnet_prefixes
  db_subnet_prefixes         = var.db_subnet_prefixes
  gateway_subnet_prefixes    = var.gateway_subnet_prefixes
  
  # Features opcionais
  create_gateway_subnet       = var.create_gateway_subnet
  enable_container_delegation = var.enable_container_delegation

  # Tags
  tags = merge(var.tags, {
    Environment = var.environment
    Project     = "FastFood-System"
    CreatedBy   = "Terraform"
    Module      = "VNet"
  })

  # Dependência explícita do Resource Group
  depends_on = [azurerm_resource_group.rg-postech]
}

# Kubernetes Module
module "kubernetes" {
  source = "./modules/kubernetes"

  # Configuração obrigatória
  cluster_name        = var.aks_cluster_name
  resource_group_name = azurerm_resource_group.rg-postech.name
  location           = azurerm_resource_group.rg-postech.location
  dns_prefix         = var.aks_dns_prefix
  subnet_id          = module.vnet.app_subnet_id

  # Configuração econômica
  node_count = var.aks_node_count
  vm_size    = var.aks_vm_size

  # Tags
  tags = merge(var.tags, {
    Environment = var.environment
    Project     = "FastFood-System"
    CreatedBy   = "Terraform"
    Module      = "AKS"
  })

  depends_on = [azurerm_resource_group.rg-postech, module.vnet]
}

# Application Gateway Module
module "gateway" {
  source = "./modules/gateway"

  # Configuração obrigatória
  gateway_name        = var.app_gateway_name
  resource_group_name = azurerm_resource_group.rg-postech.name
  location           = azurerm_resource_group.rg-postech.location
  gateway_subnet_id  = module.vnet.gateway_subnet_id

  # Configuração econômica
  sku_name  = var.app_gateway_sku_name
  sku_tier  = var.app_gateway_sku_tier
  capacity  = var.app_gateway_capacity

  # Backend IPs (será configurado após AKS)
  backend_ip_addresses = var.app_gateway_backend_ips

  # Tags
  tags = merge(var.tags, {
    Environment = var.environment
    Project     = "FastFood-System"
    CreatedBy   = "Terraform"
    Module      = "ApplicationGateway"
  })

  depends_on = [azurerm_resource_group.rg-postech, module.vnet]
}

# PostgreSQL Database Module
module "database" {
  source = "./modules/database"

  # Configuração obrigatória
  server_name             = var.postgresql_server_name
  resource_group_name     = azurerm_resource_group.rg-postech.name
  location               = azurerm_resource_group.rg-postech.location

  # Configuração econômica
  postgresql_version = var.postgresql_version
  sku_name          = var.postgresql_sku_name
  storage_mb        = var.postgresql_storage_mb
  backup_retention_days = var.postgresql_backup_retention_days

  # Banco de dados
  database_name = var.postgresql_database_name

  # Tags
  tags = merge(var.tags, {
    Environment = var.environment
    Project     = "FastFood-System"
    CreatedBy   = "Terraform"
    Module      = "PostgreSQL"
  })

  depends_on = [azurerm_resource_group.rg-postech]
}
