output "resource_group_name" {
  description = "Nome do Resource Group criado"
  value       = azurerm_resource_group.rg-postech.name
}

output "resource_group_location" {
  description = "Localização do Resource Group"
  value       = azurerm_resource_group.rg-postech.location
}

output "resource_group_id" {
  description = "ID do Resource Group"
  value       = azurerm_resource_group.rg-postech.id
}

# Storage Account Outputs
output "storage_account_name" {
  description = "Nome do Storage Account criado"
  value       = azurerm_storage_account.tfstate.name
}

output "storage_container_name" {
  description = "Nome do Container criado"
  value       = azurerm_storage_container.tfstate.name
}

# ============================================
# VNet Module Outputs
# ============================================

output "vnet_id" {
  description = "ID da Virtual Network"
  value       = module.vnet.vnet_id
}

output "vnet_name" {
  description = "Nome da Virtual Network"
  value       = module.vnet.vnet_name
}

output "vnet_address_space" {
  description = "Espaço de endereçamento da VNet"
  value       = module.vnet.vnet_address_space
}

output "app_subnet_id" {
  description = "ID da subnet de aplicações"
  value       = module.vnet.app_subnet_id
}

output "app_subnet_name" {
  description = "Nome da subnet de aplicações"
  value       = module.vnet.app_subnet_name
}

output "db_subnet_id" {
  description = "ID da subnet de banco de dados"
  value       = module.vnet.db_subnet_id
}

output "db_subnet_name" {
  description = "Nome da subnet de banco de dados"
  value       = module.vnet.db_subnet_name
}

output "app_nsg_id" {
  description = "ID do NSG da subnet de aplicações"
  value       = module.vnet.app_nsg_id
}

output "db_nsg_id" {
  description = "ID do NSG da subnet de banco"
  value       = module.vnet.db_nsg_id
}

# Output estruturado completo
output "vnet_info" {
  description = "Informações completas da VNet e subnets"
  value       = module.vnet.vnet_info
}