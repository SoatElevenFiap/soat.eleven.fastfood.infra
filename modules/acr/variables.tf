# Required variables
variable "acr_name" {
  description = "Nome do Azure Container Registry"
  type        = string
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9]{5,50}$", var.acr_name))
    error_message = "O nome do ACR deve ter entre 5-50 caracteres alfanuméricos."
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
  description = "SKU do Container Registry - Basic recomendado para economia"
  type        = string
  default     = "Basic"
  
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku_name)
    error_message = "SKU deve ser Basic, Standard ou Premium."
  }
}

variable "admin_enabled" {
  description = "Habilitar admin user para o ACR"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Permitir acesso público ao ACR - habilitado para simplicidade"
  type        = bool
  default     = true
}

variable "retention_days" {
  description = "Dias de retenção para imagens não marcadas"
  type        = number
  default     = 7
}

variable "retention_enabled" {
  description = "Habilitar política de retenção"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags para aplicar aos recursos"
  type        = map(string)
  default     = {}
}