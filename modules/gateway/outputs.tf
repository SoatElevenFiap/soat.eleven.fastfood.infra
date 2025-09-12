# Application Gateway outputs essenciais
output "gateway_id" {
  description = "ID do Application Gateway"
  value       = azurerm_application_gateway.main.id
}

output "gateway_name" {
  description = "Nome do Application Gateway"
  value       = azurerm_application_gateway.main.name
}

output "public_ip_address" {
  description = "Endereço IP público do Application Gateway"
  value       = azurerm_public_ip.app_gateway.ip_address
}

output "gateway_fqdn" {
  description = "FQDN do Application Gateway"
  value       = azurerm_public_ip.app_gateway.fqdn
}

output "public_ip_id" {
  description = "ID do IP público"
  value       = azurerm_public_ip.app_gateway.id
}