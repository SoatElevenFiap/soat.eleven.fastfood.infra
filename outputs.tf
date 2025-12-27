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
# output "storage_account_name" {
#   description = "Nome do Storage Account criado"
#   value       = azurerm_storage_account.tfstate.name
# }

# output "storage_container_name" {
#   description = "Nome do Container criado"
#   value       = azurerm_storage_container.tfstate.name
# }

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
      vnet_name         = module.vnet.vnet_name
      vnet_id           = module.vnet.vnet_id
      app_subnet_id     = module.vnet.app_subnet_id
      db_subnet_id      = module.vnet.db_subnet_id
      gateway_subnet_id = module.vnet.gateway_subnet_id
    }
    kubernetes = {
      cluster_name = module.kubernetes.cluster_name
      cluster_fqdn = module.kubernetes.cluster_fqdn
      node_rg      = module.kubernetes.node_resource_group
    }
    gateway = {
      name      = module.gateway.gateway_name
      public_ip = module.gateway.public_ip_address
      fqdn      = module.gateway.gateway_fqdn
    }
    acr = {
      name         = module.acr.acr_name
      login_server = module.acr.login_server
      id           = module.acr.acr_id
    }
  }
}

# ============================================
# Azure Container Registry Outputs
# ============================================

output "acr_id" {
  description = "ID do Azure Container Registry"
  value       = module.acr.acr_id
}

output "acr_name" {
  description = "Nome do Azure Container Registry"
  value       = module.acr.acr_name
}

output "acr_login_server" {
  description = "URL do servidor de login do ACR"
  value       = module.acr.login_server
}

output "acr_admin_username" {
  description = "Nome de usuário admin do ACR"
  value       = module.acr.admin_username
  sensitive   = true
}

output "acr_admin_password" {
  description = "Senha admin do ACR"
  value       = module.acr.admin_password
  sensitive   = true
}

# ============================================
# Azure Key Vault Outputs
# ============================================

output "keyvault_id" {
  description = "ID do Azure Key Vault"
  value       = module.keyvault.keyvault_id
}

output "keyvault_name" {
  description = "Nome do Azure Key Vault"
  value       = module.keyvault.keyvault_name
}

output "keyvault_uri" {
  description = "URI do Azure Key Vault"
  value       = module.keyvault.keyvault_uri
}

output "keyvault_tenant_id" {
  description = "Tenant ID do Azure Key Vault"
  value       = module.keyvault.tenant_id
}

output "database_secret_name" {
  description = "Nome do secret da connection string do banco"
  value       = module.keyvault.database_secret_name
  sensitive   = true
}

output "redis_secret_name" {
  description = "Nome do secret da connection string do Redis no Key Vault"
  value       = module.keyvault.redis_secret_name
}

output "redis_secret_id" {
  description = "ID do secret da connection string do Redis no Key Vault"
  value       = module.keyvault.redis_secret_id
}

output "mongodb_secret_name" {
  description = "Nome do secret da connection string do MongoDB no Key Vault"
  value       = module.keyvault.mongodb_secret_name
}

output "mongodb_secret_id" {
  description = "ID do secret da connection string do MongoDB no Key Vault"
  value       = module.keyvault.mongodb_secret_id
}

# ============================================
# Azure Cache for Redis Outputs
# ============================================

output "redis_id" {
  description = "ID do Azure Cache for Redis"
  value       = module.redis.redis_id
}

output "redis_name" {
  description = "Nome do Azure Cache for Redis"
  value       = module.redis.redis_name
}

output "redis_hostname" {
  description = "Hostname do Redis Cache"
  value       = module.redis.hostname
}

output "redis_ssl_port" {
  description = "Porta SSL do Redis (6380)"
  value       = module.redis.ssl_port
}

output "redis_port" {
  description = "Porta não-SSL do Redis (6379)"
  value       = module.redis.port
}

output "redis_primary_connection_string" {
  description = "Connection string primária do Redis"
  value       = module.redis.primary_connection_string
  sensitive   = true
}

# ============================================
# MongoDB Outputs (Container no AKS)
# ============================================

output "mongodb_database_name" {
  description = "Nome do banco de dados MongoDB (será criado no container)"
  value       = var.mongodb_database_name
}

output "mongodb_info" {
  description = "Informações sobre o MongoDB (deploy manual no AKS)"
  value = {
    note            = "MongoDB será deployado como container no AKS usando StatefulSet"
    database_name   = var.mongodb_database_name
    connection_info = "Após deploy do MongoDB no AKS, use o Service 'mongodb' na porta 27017"
  }
}