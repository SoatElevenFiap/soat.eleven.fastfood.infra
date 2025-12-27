# Required variables
variable "cosmosdb_name" {
  description = "Nome do Azure Cosmos DB Account"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z0-9-]{3,44}$", var.cosmosdb_name))
    error_message = "O nome do Cosmos DB deve ter entre 3-44 caracteres, apenas letras minúsculas, números e hífens."
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

variable "database_name" {
  description = "Nome do banco de dados MongoDB"
  type        = string
  default     = "fastfood"
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]{1,255}$", var.database_name))
    error_message = "O nome do banco de dados deve ter entre 1-255 caracteres alfanuméricos, hífens ou underscores."
  }
}

# Optional variables - Configuração Econômica para Estudantes
variable "offer_type" {
  description = "Tipo de oferta do Cosmos DB (Standard ou Serverless)"
  type        = string
  default     = "Standard"
  
  validation {
    condition     = contains(["Standard"], var.offer_type)
    error_message = "Offer type deve ser Standard (Serverless não suportado para MongoDB API)."
  }
}

variable "consistency_level" {
  description = "Nível de consistência do Cosmos DB"
  type        = string
  default     = "Session"
  
  validation {
    condition = contains([
      "Eventual",
      "ConsistentPrefix",
      "Session",
      "BoundedStaleness",
      "Strong"
    ], var.consistency_level)
    error_message = "Nível de consistência inválido."
  }
}

variable "max_interval_in_seconds" {
  description = "Intervalo máximo em segundos para BoundedStaleness"
  type        = number
  default     = 5
  
  validation {
    condition     = var.max_interval_in_seconds >= 5 && var.max_interval_in_seconds <= 86400
    error_message = "Intervalo máximo deve estar entre 5 e 86400 segundos."
  }
}

variable "max_staleness_prefix" {
  description = "Prefixo máximo de staleness para BoundedStaleness"
  type        = number
  default     = 100
  
  validation {
    condition     = var.max_staleness_prefix >= 10 && var.max_staleness_prefix <= 1000000
    error_message = "Prefixo de staleness deve estar entre 10 e 1000000."
  }
}

variable "subnet_id" {
  description = "ID da subnet para integração com VNet (opcional)"
  type        = string
  default     = null
}

variable "database_throughput" {
  description = "Throughput do banco de dados (RU/s) - mínimo 400 para Standard"
  type        = number
  default     = 400
  
  validation {
    condition     = var.database_throughput >= 400
    error_message = "Throughput mínimo é 400 RU/s para Standard."
  }
}

variable "backup_interval_in_minutes" {
  description = "Intervalo de backup em minutos"
  type        = number
  default     = 240
  
  validation {
    condition     = contains([60, 240, 480, 720, 1440], var.backup_interval_in_minutes)
    error_message = "Intervalo de backup deve ser 60, 240, 480, 720 ou 1440 minutos."
  }
}

variable "backup_retention_in_hours" {
  description = "Retenção de backup em horas"
  type        = number
  default     = 8
  
  validation {
    condition     = var.backup_retention_in_hours >= 8 && var.backup_retention_in_hours <= 720
    error_message = "Retenção de backup deve estar entre 8 e 720 horas."
  }
}

variable "backup_storage_redundancy" {
  description = "Redundância de armazenamento do backup"
  type        = string
  default     = "Geo"
  
  validation {
    condition     = contains(["Local", "Geo", "Zone"], var.backup_storage_redundancy)
    error_message = "Redundância de backup deve ser Local, Geo ou Zone."
  }
}

variable "tags" {
  description = "Tags para aplicar aos recursos"
  type        = map(string)
  default     = {}
}

