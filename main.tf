# Data sources para referenciar recursos existentes
data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "existing" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

# PostgreSQL Database Module
module "database" {
  source = "./modules/database"

  # Configuração obrigatória
  server_name             = var.postgresql_server_name
  resource_group_name     = data.azurerm_resource_group.existing.name
  location               = data.azurerm_resource_group.existing.location

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
}
