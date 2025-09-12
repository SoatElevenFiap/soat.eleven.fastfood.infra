# Azure Database for PostgreSQL Flexible Server - Configuração Econômica
resource "azurerm_postgresql_flexible_server" "main" {
  name                   = var.server_name
  resource_group_name    = var.resource_group_name
  location              = var.location
  version               = var.postgresql_version
  administrator_login    = "adm"
  administrator_password = "adm123"
  
  # Storage configuration (mínimo)
  storage_mb = var.storage_mb
  
  # SKU configuration (econômico)
  sku_name = var.sku_name
  
  # Backup configuration (mínimo)
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = false  # Desabilitado para economia
  
  tags = var.tags
}

# PostgreSQL Database
resource "azurerm_postgresql_flexible_server_database" "main" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.main.id
  collation = "en_US.utf8"
  charset   = "UTF8"
}