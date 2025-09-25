variable "resource_group_name" {
  description = "Nome do Resource Group"
  type        = string
  default     = "rg-fastfood-postech"

  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "O nome do Resource Group não pode estar vazio."
  }
}


variable "location" {
  description = "Localização dos recursos no Azure"
  type        = string
  default     = "Brazil South"

  validation {
    condition = contains([
      "West US 3",
      "West US 2",
      "East US",
      "Central US",
      "South Central US",
      "North Central US",
      "Brazil South",
      "West Europe",
      "North Europe"
    ], var.location)
    error_message = "A localização deve ser uma região válida do Azure."
  }
}

variable "environment" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "O ambiente deve ser: dev, staging ou prod."
  }
}

variable "tags" {
  description = "Tags adicionais para aplicar aos recursos"
  type        = map(string)
  default     = {}
}

variable "fiap_base_rg_name" {
  description = "Nome do Resource Group base para o FASTFOOD"
  type        = string
  default     = "rg-fiap-fastfood"
}

variable "storage_account_name" {
  description = "FastFood Storage Account"
  type        = string
  default     = "storagefiapfastfood"
}
variable "terraform_storage_container_name" {
  description = "FastFood Storage Account"
  type        = string
  default     = "fastfood-tfstate"
}

# ============================================
# VNet Module Variables
# ============================================

variable "vnet_name" {
  description = "Nome da Virtual Network"
  type        = string
  default     = "vnet-fastfood-postech"

  validation {
    condition     = length(var.vnet_name) > 0
    error_message = "O nome da VNet não pode estar vazio."
  }
}

variable "vnet_address_space" {
  description = "Espaço de endereçamento da VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]

  validation {
    condition     = length(var.vnet_address_space) > 0
    error_message = "Pelo menos um espaço de endereçamento deve ser especificado."
  }
}

variable "app_subnet_prefixes" {
  description = "Prefixos de endereço para subnet de aplicações"
  type        = list(string)
  default     = ["10.0.1.0/24"]

  validation {
    condition     = length(var.app_subnet_prefixes) > 0
    error_message = "Pelo menos um prefixo de subnet deve ser especificado."
  }
}

variable "db_subnet_prefixes" {
  description = "Prefixos de endereço para subnet de banco de dados"
  type        = list(string)
  default     = ["10.0.2.0/24"]

  validation {
    condition     = length(var.db_subnet_prefixes) > 0
    error_message = "Pelo menos um prefixo de subnet deve ser especificado."
  }
}

variable "app_gateway_subnet_prefixes" {
  description = "Prefixos de endereço para subnet do Application Gateway"
  type        = list(string)
  default     = ["10.0.3.0/24"]
}

variable "gateway_subnet_prefixes" {
  description = "Prefixos de endereço para Gateway Subnet (VPN/ExpressRoute)"
  type        = list(string)
  default     = ["10.0.255.0/27"]
}

variable "create_gateway_subnet" {
  description = "Se deve criar Gateway Subnet para VPN/ExpressRoute"
  type        = bool
  default     = false
}

variable "enable_container_delegation" {
  description = "Se deve habilitar delegação para Azure Container Instances na subnet de app"
  type        = bool
  default     = true
}

# =================
# AKS Variables (Configuração Simples e Econômica)
# =================
variable "aks_cluster_name" {
  description = "Nome do cluster AKS"
  type        = string
  default     = "aks-fastfood-postech"
}

variable "aks_dns_prefix" {
  description = "Prefixo DNS para o cluster AKS"
  type        = string
  default     = "fastfood-postech"
}

variable "aks_node_count" {
  description = "Número de nós no cluster AKS"
  type        = number
  default     = 1

  validation {
    condition     = var.aks_node_count >= 1 && var.aks_node_count <= 5
    error_message = "O número de nós deve estar entre 1 e 5 para economia."
  }
}

variable "aks_vm_size" {
  description = "Tamanho da VM para os nós AKS (econômico)"
  type        = string
  default     = "Standard_E2s_v3"

  validation {
    condition = contains([
      "Standard_B1s",
      "Standard_B2s",
      "Standard_B1ms",
      "Standard_B2ms",
      "Standard_D2ps_v6",
      "Standard_E2s_v3"
    ], var.aks_vm_size)
    error_message = "Use um tamanho de VM econômico (série B ou DS2_v2)."
  }
}

variable "aks_kubernetes_version" {
  description = "Versão do Kubernetes"
  type        = string
  default     = "1.28.3"
}

variable "aks_network_plugin" {
  description = "Plugin de rede do AKS"
  type        = string
  default     = "kubenet"

  validation {
    condition = contains([
      "kubenet",
      "azure"
    ], var.aks_network_plugin)
    error_message = "Plugin de rede deve ser kubenet ou azure."
  }
}

# =================
# Application Gateway Variables (Configuração Simples e Econômica)
# =================
variable "app_gateway_name" {
  description = "Nome do Application Gateway"
  type        = string
  default     = "agw-fastfood-postech"
}

variable "app_gateway_sku_name" {
  description = "Nome do SKU do Application Gateway"
  type        = string
  default     = "Standard_v2"

  validation {
    condition = contains([
      "Standard_v2",
      "WAF_v2"
    ], var.app_gateway_sku_name)
    error_message = "Use um SKU suportado: Standard_v2 ou WAF_v2 (v1 foi descontinuado)."
  }
}

variable "app_gateway_sku_tier" {
  description = "Tier do SKU do Application Gateway"
  type        = string
  default     = "Standard_v2"

  validation {
    condition     = contains(["Standard_v2", "WAF_v2"], var.app_gateway_sku_tier)
    error_message = "Tier deve ser Standard_v2 ou WAF_v2 (v1 foi descontinuado)."
  }
}

variable "app_gateway_capacity" {
  description = "Capacidade do Application Gateway"
  type        = number
  default     = 1

  validation {
    condition     = var.app_gateway_capacity >= 1 && var.app_gateway_capacity <= 3
    error_message = "Capacidade deve estar entre 1 e 3 para economia."
  }
}

variable "app_gateway_backend_ips" {
  description = "Lista de IPs do backend para o Application Gateway"
  type        = list(string)
  default     = []
}

# =================
# PostgreSQL Variables (Configuração Simples e Econômica)
# =================
variable "postgresql_server_name" {
  description = "Nome do servidor PostgreSQL"
  type        = string
  default     = "psql-fastfood-postech"
}

variable "postgresql_version" {
  description = "Versão do PostgreSQL"
  type        = string
  default     = "14"
}

variable "postgresql_sku_name" {
  description = "Nome do SKU do PostgreSQL (econômico)"
  type        = string
  default     = "B_Standard_B1ms"

  validation {
    condition = contains([
      "B_Standard_B1ms",
      "B_Standard_B2s",
      "GP_Standard_D2s_v3"
    ], var.postgresql_sku_name)
    error_message = "Use um SKU econômico (Basic B1ms, B2s ou GP D2s_v3)."
  }
}

variable "postgresql_storage_mb" {
  description = "Armazenamento do PostgreSQL em MB"
  type        = number
  default     = 32768 # 32GB

  validation {
    condition     = var.postgresql_storage_mb >= 32768 && var.postgresql_storage_mb <= 65536
    error_message = "O armazenamento deve estar entre 32GB e 64GB para economia."
  }
}

variable "postgresql_backup_retention_days" {
  description = "Dias de retenção de backup do PostgreSQL"
  type        = number
  default     = 7

  validation {
    condition     = var.postgresql_backup_retention_days >= 7 && var.postgresql_backup_retention_days <= 14
    error_message = "A retenção de backup deve estar entre 7 e 14 dias para economia."
  }
}

variable "postgresql_database_name" {
  description = "Nome do banco de dados principal"
  type        = string
  default     = "fastfood"
}