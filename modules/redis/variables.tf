# Required variables
variable "redis_name" {
  description = "Nome do Azure Cache for Redis"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]*[a-z0-9]$|^[a-z0-9]$", lower(var.redis_name))) && length(var.redis_name) >= 1 && length(var.redis_name) <= 63
    error_message = "O nome do Redis deve ter entre 1-63 caracteres, apenas letras minúsculas, números e hífens (não pode começar ou terminar com hífen)."
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
variable "capacity" {
  description = "Capacidade do Redis Cache (0 = Basic/Standard C0, 1 = C1, 2 = C2, etc.)"
  type        = number
  default     = 0

  validation {
    condition     = contains([0, 1, 2], var.capacity)
    error_message = "Capacidade deve ser 0 (C0), 1 (C1) ou 2 (C2) para economia."
  }
}

variable "family" {
  description = "Família do SKU (C = Basic/Standard, P = Premium)"
  type        = string
  default     = "C"

  validation {
    condition     = contains(["C", "P"], var.family)
    error_message = "Família deve ser C (Basic/Standard) ou P (Premium)."
  }
}

variable "subnet_id" {
  description = "ID da subnet para integração com VNet (opcional)"
  type        = string
  default     = null
}

variable "enable_non_ssl_port" {
  description = "Habilitar porta não-SSL (6379) - desabilitado por padrão por segurança"
  type        = bool
  default     = false
}

variable "minimum_tls_version" {
  description = "Versão mínima de TLS"
  type        = string
  default     = "1.2"

  validation {
    condition     = contains(["1.0", "1.1", "1.2"], var.minimum_tls_version)
    error_message = "Versão TLS deve ser 1.0, 1.1 ou 1.2."
  }
}

variable "maxmemory_reserved" {
  description = "Memória reservada para operações não-cache (MB)"
  type        = number
  default     = 2
}

variable "maxmemory_delta" {
  description = "Delta de memória para operações (MB)"
  type        = number
  default     = 2
}

variable "maxmemory_policy" {
  description = "Política de eviction quando memória está cheia"
  type        = string
  default     = "allkeys-lru"

  validation {
    condition = contains([
      "noeviction",
      "allkeys-lru",
      "volatile-lru",
      "allkeys-random",
      "volatile-random",
      "volatile-ttl"
    ], var.maxmemory_policy)
    error_message = "Política de memória inválida."
  }
}

variable "app_subnet_cidr" {
  description = "CIDR da subnet de aplicação para firewall rule (opcional)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags para aplicar aos recursos"
  type        = map(string)
  default     = {}
}

