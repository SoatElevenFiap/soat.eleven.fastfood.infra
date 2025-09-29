variable "apim_name" {
  description = "Nome do API Management"
  type        = string
}

variable "resource_group_name" {
  description = "Nome do Resource Group"
  type        = string
}

variable "location" {
  description = "Localização do recurso"
  type        = string
}

variable "publisher_name" {
  description = "Nome do publisher do API Management"
  type        = string
}

variable "publisher_email" {
  description = "Email do publisher do API Management"
  type        = string
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.publisher_email))
    error_message = "O email deve ter um formato válido."
  }
}

variable "sku_name" {
  description = "SKU do API Management"
  type        = string
  default     = "Developer_1"
  
  validation {
    condition = contains([
      "Developer_1",
      "Basic_1", 
      "Standard_1"
    ], var.sku_name)
    error_message = "Use um SKU econômico: Developer_1, Basic_1 ou Standard_1."
  }
}

variable "apim_subnet_id" {
  description = "ID da subnet onde o APIM será implantado"
  type        = string
}

variable "tags" {
  description = "Tags para aplicar ao recurso"
  type        = map(string)
  default     = {}
}