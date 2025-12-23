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
      "North Europe",
      "Canada Central"
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

# ============================================
# Azure Container Registry Variables
# ============================================

variable "acr_name" {
  description = "Nome do Azure Container Registry"
  type        = string
  default     = "acrfastfoodpostech"
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9]{5,50}$", var.acr_name))
    error_message = "O nome do ACR deve ter entre 5-50 caracteres alfanuméricos."
  }
}

variable "acr_sku_name" {
  description = "SKU do Container Registry (Basic, Standard, Premium)"
  type        = string
  default     = "Basic"
  
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.acr_sku_name)
    error_message = "SKU deve ser Basic, Standard ou Premium."
  }
}

variable "acr_admin_enabled" {
  description = "Habilitar admin user para o ACR"
  type        = bool
  default     = true
}

# ============================================
# Azure Key Vault Variables
# ============================================

variable "keyvault_name" {
  description = "Nome do Azure Key Vault"
  type        = string
  default     = "kv-fastfood-postech-19"
  
  validation {
    condition     = can(regex("^[a-zA-Z]([a-zA-Z0-9-]){1,22}[a-zA-Z0-9]$", var.keyvault_name))
    error_message = "O nome do Key Vault deve ter entre 3-24 caracteres, começar com letra, e conter apenas letras, números e hífens."
  }
}

variable "keyvault_sku_name" {
  description = "SKU do Key Vault (standard ou premium)"
  type        = string
  default     = "standard"
  
  validation {
    condition     = contains(["standard", "premium"], var.keyvault_sku_name)
    error_message = "SKU deve ser standard ou premium."
  }
}

# ============================================