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

# ============================================
# AKS Module Outputs
# ============================================

output "aks_cluster_id" {
  description = "ID do cluster AKS"
  value       = module.kubernetes.cluster_id
}

output "aks_cluster_name" {
  description = "Nome do cluster AKS"
  value       = module.kubernetes.cluster_name
}

output "aks_cluster_fqdn" {
  description = "FQDN do cluster AKS"
  value       = module.kubernetes.cluster_fqdn
}

output "aks_kube_config" {
  description = "Configuração do kubectl"
  value       = module.kubernetes.kube_config
  sensitive   = true
}

output "aks_cluster_identity" {
  description = "Identidade do cluster AKS"
  value       = module.kubernetes.cluster_identity
}

output "aks_node_resource_group" {
  description = "Resource Group dos nós do AKS"
  value       = module.kubernetes.node_resource_group
}

# ============================================
# Application Gateway Module Outputs
# ============================================

output "app_gateway_id" {
  description = "ID do Application Gateway"
  value       = module.gateway.gateway_id
}

output "app_gateway_name" {
  description = "Nome do Application Gateway"
  value       = module.gateway.gateway_name
}

output "app_gateway_public_ip" {
  description = "IP público do Application Gateway"
  value       = module.gateway.public_ip_address
}

output "app_gateway_fqdn" {
  description = "FQDN do Application Gateway"
  value       = module.gateway.gateway_fqdn
}

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

output "postgresql_databases" {
  description = "Lista de bancos de dados criados"
  value       = module.database.databases
}

output "postgresql_connection_string" {
  description = "String de conexão do PostgreSQL"
  value       = module.database.connection_string
  sensitive   = true
}

# ============================================
# Summary Outputs
# ============================================

output "infrastructure_summary" {
  description = "Resumo da infraestrutura criada"
  value = {
    resource_group = {
      name     = azurerm_resource_group.rg-postech.name
      location = azurerm_resource_group.rg-postech.location
    }
    networking = {
      vnet_name       = module.vnet.vnet_name
      vnet_id         = module.vnet.vnet_id
      app_subnet_id   = module.vnet.app_subnet_id
      db_subnet_id    = module.vnet.db_subnet_id
      gateway_subnet_id = module.vnet.gateway_subnet_id
    }
    kubernetes = {
      cluster_name = module.kubernetes.cluster_name
      cluster_fqdn = module.kubernetes.cluster_fqdn
      node_rg      = module.kubernetes.node_resource_group
    }
    gateway = {
      name       = module.gateway.gateway_name
      public_ip  = module.gateway.public_ip_address
      fqdn       = module.gateway.gateway_fqdn
    }
    database = {
      server_name = module.database.server_name
      server_fqdn = module.database.server_fqdn
      databases   = module.database.databases
    }
  }
}