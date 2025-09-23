# ============================================
# PostgreSQL Module Outputs
# ============================================

output "postgresql_server_id" {
  description = "ID do servidor PostgreSQL"
  value       = module.database.server_id
}

output "postgresql_server_name" {
  description = "Nome do servidor PostgreSQL"
  value       = module.database.server_name
}

output "postgresql_server_fqdn" {
  description = "FQDN do servidor PostgreSQL"
  value       = module.database.server_fqdn
}

output "postgresql_database_name" {
  description = "Nome do banco de dados criado"
  value       = module.database.database_name
}

output "postgresql_connection_string" {
  description = "String de conexão do PostgreSQL"
  value       = module.database.connection_string
  sensitive   = true
}

output "postgresql_administrator_login" {
  description = "Login do administrador PostgreSQL"
  value       = module.database.administrator_login
}

# ============================================
# Resource Group Information (para referência)
# ============================================

output "resource_group_name" {
  description = "Nome do Resource Group utilizado"
  value       = data.azurerm_resource_group.existing.name
}

output "resource_group_location" {
  description = "Localização do Resource Group"
  value       = data.azurerm_resource_group.existing.location
}

# ============================================
# Summary Output
# ============================================

output "database_summary" {
  description = "Resumo do banco de dados PostgreSQL criado"
  value = {
    server_name   = module.database.server_name
    server_fqdn   = module.database.server_fqdn
    database_name = module.database.database_name
    admin_login   = module.database.administrator_login
  }
}