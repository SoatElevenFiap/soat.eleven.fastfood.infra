# Create a resource group
resource "azurerm_resource_group" "rg-postech" {
  name     = var.fiap_base_rg_name
  location = "Central US"

  tags = {
    Environment = "dev"
    Project     = "FastFood-System"
    CreatedBy   = "Terraform"
  }
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
  admin_source_address_prefix = var.admin_source_address_prefix

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
