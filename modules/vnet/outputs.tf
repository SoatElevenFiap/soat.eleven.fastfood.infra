# Virtual Network Module Outputs

output "vnet_id" {
  description = "ID da Virtual Network criada"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Nome da Virtual Network"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_address_space" {
  description = "Espaço de endereçamento da VNet"
  value       = azurerm_virtual_network.vnet.address_space
}

output "app_subnet_id" {
  description = "ID da subnet de aplicações"
  value       = azurerm_subnet.app_subnet.id
}

output "app_subnet_name" {
  description = "Nome da subnet de aplicações"
  value       = azurerm_subnet.app_subnet.name
}

output "app_subnet_address_prefixes" {
  description = "Prefixos de endereço da subnet de aplicações"
  value       = azurerm_subnet.app_subnet.address_prefixes
}

output "db_subnet_id" {
  description = "ID da subnet de banco de dados"
  value       = azurerm_subnet.db_subnet.id
}

output "db_subnet_name" {
  description = "Nome da subnet de banco de dados"
  value       = azurerm_subnet.db_subnet.name
}

output "db_subnet_address_prefixes" {
  description = "Prefixos de endereço da subnet de banco de dados"
  value       = azurerm_subnet.db_subnet.address_prefixes
}

output "gateway_subnet_id" {
  description = "ID da Gateway Subnet (se criada)"
  value       = var.create_gateway_subnet ? azurerm_subnet.gateway_subnet[0].id : null
}

output "app_gateway_subnet_id" {
  description = "ID da subnet do Application Gateway"
  value       = azurerm_subnet.app_gateway_subnet.id
}

output "gateway_subnet_name" {
  description = "Nome da Gateway Subnet (se criada)"
  value       = var.create_gateway_subnet ? azurerm_subnet.gateway_subnet[0].name : null
}

output "gateway_subnet_address_prefixes" {
  description = "Prefixos de endereço da Gateway Subnet (se criada)"
  value       = var.create_gateway_subnet ? azurerm_subnet.gateway_subnet[0].address_prefixes : null
}

# NSGs simplificados
output "app_nsg_id" {
  description = "ID do NSG da app (removido para simplificação)"
  value       = null
}

output "db_nsg_id" {
  description = "ID do NSG do banco de dados"
  value       = azurerm_network_security_group.db_nsg.id
}

# Outputs estruturados para compatibilidade
output "vnet_info" {
  description = "Informações completas da VNet"
  value = {
    id            = azurerm_virtual_network.vnet.id
    name          = azurerm_virtual_network.vnet.name
    location      = azurerm_virtual_network.vnet.location
    address_space = azurerm_virtual_network.vnet.address_space
    
    subnets = {
      app = {
        id               = azurerm_subnet.app_subnet.id
        name             = azurerm_subnet.app_subnet.name
        address_prefixes = azurerm_subnet.app_subnet.address_prefixes
        nsg_id          = null  # NSG removido
      }
      
      db = {
        id               = azurerm_subnet.db_subnet.id
        name             = azurerm_subnet.db_subnet.name
        address_prefixes = azurerm_subnet.db_subnet.address_prefixes
        nsg_id          = azurerm_network_security_group.db_nsg.id
      }
      
      gateway = var.create_gateway_subnet ? {
        id               = azurerm_subnet.gateway_subnet[0].id
        name             = azurerm_subnet.gateway_subnet[0].name
        address_prefixes = azurerm_subnet.gateway_subnet[0].address_prefixes
      } : null
    }
  }
}