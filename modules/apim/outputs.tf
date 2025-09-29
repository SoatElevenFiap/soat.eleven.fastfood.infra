output "apim_id" {
  description = "ID do API Management"
  value       = azurerm_api_management.main.id
}

output "apim_name" {
  description = "Nome do API Management"
  value       = azurerm_api_management.main.name
}

output "apim_gateway_url" {
  description = "URL do gateway do API Management"
  value       = azurerm_api_management.main.gateway_url
}

output "apim_public_ip_addresses" {
  description = "IPs públicos do API Management"
  value       = azurerm_api_management.main.public_ip_addresses
}

output "apim_private_ip_addresses" {
  description = "IPs privados do API Management"
  value       = azurerm_api_management.main.private_ip_addresses
}

output "apim_management_api_url" {
  description = "URL da API de gerenciamento"
  value       = azurerm_api_management.main.management_api_url
}

output "apim_portal_url" {
  description = "URL do portal do desenvolvedor"
  value       = azurerm_api_management.main.portal_url
}

output "apim_nsg_id" {
  description = "ID do Network Security Group do APIM"
  value       = azurerm_network_security_group.apim_nsg.id
}

output "apim_nsg_name" {
  description = "Nome do Network Security Group do APIM"
  value       = azurerm_network_security_group.apim_nsg.name
}