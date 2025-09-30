# Required variables
variable "keyvault_name" {
  description = "Nome do Azure Key Vault"
  type        = string
  
  validation {
    condition     = can(regex("^[a-zA-Z]([a-zA-Z0-9-]){1,22}[a-zA-Z0-9]$", var.keyvault_name))
    error_message = "O nome do Key Vault deve ter entre 3-24 caracteres, começar com letra, e conter apenas letras, números e hífens."
  }
}

variable "resource_group_name" {
  description = "Nome do Resource Group"
  type        = string
}

variable "location" {
  description = "Localização do Azure"
  type        = string
}

# Optional variables - Configuração Econômica para Estudantes
variable "sku_name" {
  description = "SKU do Key Vault (standard ou premium)"
  type        = string
  default     = "standard"
  
  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "SKU deve ser standard ou premium."
  }
}

variable "enabled_for_deployment" {
  description = "Permitir que o Azure Virtual Machines recupere certificados"
  type        = bool
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Permitir que o Azure Disk Encryption recupere segredos"
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Permitir que o Azure Resource Manager recupere segredos"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Permitir acesso público ao Key Vault"
  type        = bool
  default     = true
}

variable "soft_delete_retention_days" {
  description = "Dias de retenção para soft delete"
  type        = number
  default     = 7
  
  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "Dias de retenção devem estar entre 7 e 90."
  }
}

variable "purge_protection_enabled" {
  description = "Habilitar proteção contra purge"
  type        = bool
  default     = false
}

# Permissões do usuário atual
variable "current_user_key_permissions" {
  description = "Permissões de chaves para o usuário atual"
  type        = list(string)
  default     = ["Get", "List", "Create", "Delete", "Update", "Recover", "Backup", "Restore"]
}

variable "current_user_secret_permissions" {
  description = "Permissões de segredos para o usuário atual"
  type        = list(string)
  default     = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"]
}

variable "current_user_certificate_permissions" {
  description = "Permissões de certificados para o usuário atual"
  type        = list(string)
  default     = ["Get", "List", "Create", "Delete", "Update", "Import", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers"]
}

# Integração com Function App
variable "function_app_principal_id" {
  description = "Principal ID da Function App para acesso ao Key Vault"
  type        = string
  default     = null
}

variable "function_app_secret_permissions" {
  description = "Permissões de segredos para a Function App"
  type        = list(string)
  default     = ["Get", "List"]
}

# Integração com banco de dados
variable "database_connection_string" {
  description = "Connection string do banco de dados para armazenar no Key Vault"
  type        = string
  default     = null
  sensitive   = true
}

variable "tags" {
  description = "Tags para aplicar aos recursos"
  type        = map(string)
  default     = {}
}