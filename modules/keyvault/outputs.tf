# Key Vault outputs essenciais
output "keyvault_id" {
  description = "ID do Azure Key Vault"
  value       = azurerm_key_vault.main.id
}

output "keyvault_name" {
  description = "Nome do Azure Key Vault"
  value       = azurerm_key_vault.main.name
}

output "keyvault_uri" {
  description = "URI do Azure Key Vault"
  value       = azurerm_key_vault.main.vault_uri
}

output "tenant_id" {
  description = "Tenant ID do Azure"
  value       = azurerm_key_vault.main.tenant_id
}

output "resource_group_name" {
  description = "Nome do Resource Group"
  value       = azurerm_key_vault.main.resource_group_name
}

output "location" {
  description = "Localização do Key Vault"
  value       = azurerm_key_vault.main.location
}

output "database_secret_name" {
  description = "Nome do secret da connection string do banco (se criado)"
  value       = var.database_connection_string != null ? azurerm_key_vault_secret.database_connection[0].name : null
}

output "database_secret_id" {
  description = "ID do secret da connection string do banco (se criado)"
  value       = var.database_connection_string != null ? azurerm_key_vault_secret.database_connection[0].id : null
}

output "redis_secret_name" {
  description = "Nome do secret da connection string do Redis (se criado)"
  value       = var.redis_connection_string != null ? azurerm_key_vault_secret.redis_connection[0].name : null
}

output "redis_secret_id" {
  description = "ID do secret da connection string do Redis (se criado)"
  value       = var.redis_connection_string != null ? azurerm_key_vault_secret.redis_connection[0].id : null
}

output "mongodb_secret_name" {
  description = "Nome do secret da connection string do MongoDB (se criado)"
  value       = var.mongodb_connection_string != null ? azurerm_key_vault_secret.mongodb_connection[0].name : null
}

output "mongodb_secret_id" {
  description = "ID do secret da connection string do MongoDB (se criado)"
  value       = var.mongodb_connection_string != null ? azurerm_key_vault_secret.mongodb_connection[0].id : null
}