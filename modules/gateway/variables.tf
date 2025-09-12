# Required variables
variable "gateway_name" {
  description = "Nome do Application Gateway"
  type        = string
}

variable "resource_group_name" {
  description = "Nome do Resource Group"
  type        = string
}

variable "location" {
  description = "Localização do Azure"
  type        = string
}

variable "gateway_subnet_id" {
  description = "ID da subnet do Application Gateway"
  type        = string
}

# Optional variables with defaults (configuração econômica)
variable "sku_name" {
  description = "Nome do SKU (econômico)"
  type        = string
  default     = "Standard_Small"
  
  validation {
    condition = contains([
      "Standard_Small",
      "Standard_Medium", 
      "Standard_v2"
    ], var.sku_name)
    error_message = "Use um SKU econômico: Standard_Small, Standard_Medium ou Standard_v2."
  }
}

variable "sku_tier" {
  description = "Tier do SKU"
  type        = string
  default     = "Standard"
  
  validation {
    condition     = contains(["Standard", "Standard_v2"], var.sku_tier)
    error_message = "Tier deve ser Standard ou Standard_v2."
  }
}

variable "capacity" {
  description = "Capacidade do Application Gateway"
  type        = number
  default     = 1
  
  validation {
    condition     = var.capacity >= 1 && var.capacity <= 3
    error_message = "Capacidade deve estar entre 1 e 3 para economia."
  }
}

variable "backend_ip_addresses" {
  description = "Lista de endereços IP do backend"
  type        = list(string)
  default     = []
}

# Tags
variable "tags" {
  description = "Tags a serem aplicadas aos recursos"
  type        = map(string)
  default     = {}
}