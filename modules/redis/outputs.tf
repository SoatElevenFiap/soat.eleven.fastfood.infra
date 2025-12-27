# Redis Cache outputs essenciais
output "redis_id" {
  description = "ID do Azure Cache for Redis"
  value       = azurerm_redis_cache.main.id
}

output "redis_name" {
  description = "Nome do Azure Cache for Redis"
  value       = azurerm_redis_cache.main.name
}

output "hostname" {
  description = "Hostname do Redis Cache"
  value       = azurerm_redis_cache.main.hostname
}

output "ssl_port" {
  description = "Porta SSL do Redis (6380)"
  value       = azurerm_redis_cache.main.ssl_port
}

output "port" {
  description = "Porta não-SSL do Redis (6379)"
  value       = azurerm_redis_cache.main.port
}

output "primary_access_key" {
  description = "Chave de acesso primária do Redis"
  value       = azurerm_redis_cache.main.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "Chave de acesso secundária do Redis"
  value       = azurerm_redis_cache.main.secondary_access_key
  sensitive   = true
}

output "primary_connection_string" {
  description = "Connection string primária do Redis"
  value       = "${azurerm_redis_cache.main.hostname}:${azurerm_redis_cache.main.ssl_port},password=${azurerm_redis_cache.main.primary_access_key},ssl=True,abortConnect=False"
  sensitive   = true
}

output "secondary_connection_string" {
  description = "Connection string secundária do Redis"
  value       = "${azurerm_redis_cache.main.hostname}:${azurerm_redis_cache.main.ssl_port},password=${azurerm_redis_cache.main.secondary_access_key},ssl=True,abortConnect=False"
  sensitive   = true
}

