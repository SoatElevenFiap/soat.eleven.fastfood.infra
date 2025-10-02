# Container Registry outputs essenciais
output "acr_id" {
  description = "ID do Azure Container Registry"
  value       = azurerm_container_registry.main.id
}

output "acr_name" {
  description = "Nome do Azure Container Registry"
  value       = azurerm_container_registry.main.name
}

output "login_server" {
  description = "URL do servidor de login do ACR (essencial para docker push/pull)"
  value       = azurerm_container_registry.main.login_server
}

output "admin_username" {
  description = "Username do admin para desenvolvimento"
  value       = azurerm_container_registry.main.admin_username
  sensitive   = true
}

output "admin_password" {
  description = "Password do admin para desenvolvimento"
  value       = azurerm_container_registry.main.admin_password
  sensitive   = true
}

output "sku" {
  description = "SKU do Container Registry"
  value       = azurerm_container_registry.main.sku
}

output "resource_group_name" {
  description = "Nome do Resource Group"
  value       = azurerm_container_registry.main.resource_group_name
}

output "location" {
  description = "Localização do ACR"
  value       = azurerm_container_registry.main.location
}

output "aks_integration_status" {
  description = "Status da integração AKS-ACR"
  value = var.aks_principal_id != "" ? "✅ Integrado automaticamente via Terraform" : "⚠️  Não integrado - configure manualmente"
}