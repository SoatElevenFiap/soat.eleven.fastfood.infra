# Cosmos DB MongoDB outputs essenciais
output "cosmosdb_id" {
  description = "ID do Azure Cosmos DB Account"
  value       = azurerm_cosmosdb_account.main.id
}

output "cosmosdb_name" {
  description = "Nome do Azure Cosmos DB Account"
  value       = azurerm_cosmosdb_account.main.name
}

output "endpoint" {
  description = "Endpoint do Cosmos DB"
  value       = azurerm_cosmosdb_account.main.endpoint
}

output "connection_strings" {
  description = "Connection strings do Cosmos DB"
  value       = azurerm_cosmosdb_account.main.connection_strings
  sensitive   = true
}

output "primary_master_key" {
  description = "Chave primária do Cosmos DB"
  value       = azurerm_cosmosdb_account.main.primary_master_key
  sensitive   = true
}

output "secondary_master_key" {
  description = "Chave secundária do Cosmos DB"
  value       = azurerm_cosmosdb_account.main.secondary_master_key
  sensitive   = true
}

output "primary_readonly_master_key" {
  description = "Chave primária somente leitura do Cosmos DB"
  value       = azurerm_cosmosdb_account.main.primary_readonly_master_key
  sensitive   = true
}

output "secondary_readonly_master_key" {
  description = "Chave secundária somente leitura do Cosmos DB"
  value       = azurerm_cosmosdb_account.main.secondary_readonly_master_key
  sensitive   = true
}

output "mongo_connection_string" {
  description = "Connection string MongoDB formatada"
  value       = "mongodb://${azurerm_cosmosdb_account.main.name}:${azurerm_cosmosdb_account.main.primary_master_key}@${replace(azurerm_cosmosdb_account.main.endpoint, "https://", "")}:10255/${var.database_name}?ssl=true&replicaSet=globaldb"
  sensitive   = true
}

output "database_id" {
  description = "ID do banco de dados MongoDB"
  value       = azurerm_cosmosdb_mongo_database.main.id
}

output "database_name" {
  description = "Nome do banco de dados MongoDB"
  value       = azurerm_cosmosdb_mongo_database.main.name
}

