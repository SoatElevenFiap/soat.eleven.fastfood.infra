# Virtual Network Module Variables

variable "vnet_name" {
  description = "Nome da Virtual Network"
  type        = string

  validation {
    condition     = length(var.vnet_name) > 0
    error_message = "O nome da VNet não pode estar vazio."
  }
}

variable "resource_group_name" {
  description = "Nome do Resource Group onde a VNet será criada"
  type        = string

  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "O nome do Resource Group não pode estar vazio."
  }
}

variable "location" {
  description = "Localização da VNet no Azure"
  type        = string

  validation {
    condition = contains([
      "West US 3", "westus3",
      "West US 2", "westus2",
      "East US", "eastus",
      "Central US", "centralus",
      "South Central US", "southcentralus",
      "North Central US", "northcentralus",
      "Brazil South", "brazilsouth",
      "West Europe", "westeurope",
      "North Europe", "northeurope"
    ], var.location)
    error_message = "A localização deve ser uma região válida do Azure."
  }
}

variable "address_space" {
  description = "Espaço de endereçamento da VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]

  validation {
    condition     = length(var.address_space) > 0
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
  default     = false
}

variable "admin_source_address_prefix" {
  description = "Prefixo de endereço de origem para acesso administrativo (SSH)"
  type        = string
  default     = "*"

  validation {
    condition = can(cidrhost(var.admin_source_address_prefix, 0)) || var.admin_source_address_prefix == "*"
    error_message = "Deve ser um CIDR válido ou '*' para qualquer origem."
  }
}

variable "tags" {
  description = "Tags para aplicar aos recursos da VNet"
  type        = map(string)
  default     = {}
}
