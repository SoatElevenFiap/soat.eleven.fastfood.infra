# Required variables
variable "server_name" {
  description = "Nome do servidor PostgreSQL"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z0-9-]{3,63}$", var.server_name))
    error_message = "O nome do servidor deve ter entre 3-63 caracteres e conter apenas letras minúsculas, números e hífens."
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



# Optional variables with defaults (configuração econômica)
variable "postgresql_version" {
  description = "Versão do PostgreSQL"
  type        = string
  default     = "14"
  
  validation {
    condition     = contains(["11", "12", "13", "14", "15"], var.postgresql_version)
    error_message = "Versão deve ser uma das: 11, 12, 13, 14, 15."
  }
}

variable "sku_name" {
  description = "Nome do SKU do PostgreSQL (econômico)"
  type        = string
  default     = "B_Standard_B1ms"
  
  validation {
    condition = contains([
      "B_Standard_B1ms",
      "B_Standard_B2s", 
      "GP_Standard_D2s_v3"
    ], var.sku_name)
    error_message = "Use um SKU econômico (Basic B1ms, B2s ou GP D2s_v3)."
  }
}

variable "storage_mb" {
  description = "Armazenamento em MB"
  type        = number
  default     = 32768  # 32GB mínimo
  
  validation {
    condition     = var.storage_mb >= 32768 && var.storage_mb <= 65536
    error_message = "O armazenamento deve estar entre 32GB (32768 MB) e 64GB (65536 MB) para economia."
  }
}

variable "backup_retention_days" {
  description = "Dias de retenção de backup"
  type        = number
  default     = 7  # Mínimo
  
  validation {
    condition     = var.backup_retention_days >= 7 && var.backup_retention_days <= 14
    error_message = "A retenção de backup deve estar entre 7 e 14 dias para economia."
  }
}

variable "database_name" {
  description = "Nome do banco de dados principal"
  type        = string
  default     = "fastfood"
}

# Tags
variable "tags" {
  description = "Tags a serem aplicadas aos recursos"
  type        = map(string)
  default     = {}
}