# PostgreSQL Server outputs essenciais
output "server_id" {
  description = "ID do servidor PostgreSQL"
  value       = azurerm_postgresql_flexible_server.main.id
}

output "server_name" {
  description = "Nome do servidor PostgreSQL"
  value       = azurerm_postgresql_flexible_server.main.name
}

output "server_fqdn" {
  description = "FQDN do servidor PostgreSQL"
  value       = azurerm_postgresql_flexible_server.main.fqdn
}

output "database_name" {
  description = "Nome do banco de dados criado"
  value       = azurerm_postgresql_flexible_server_database.main.name
}

output "connection_string" {
  description = "String de conexão do PostgreSQL"
  value       = "Host=${azurerm_postgresql_flexible_server.main.fqdn};Database=${azurerm_postgresql_flexible_server_database.main.name};Username=adm;Password=adm123"
  sensitive   = true
}

output "administrator_login" {
  description = "Login do administrador"
  value       = azurerm_postgresql_flexible_server.main.administrator_login
}