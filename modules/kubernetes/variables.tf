# Required variables
variable "cluster_name" {
  description = "Nome do cluster AKS"
  type        = string
}

variable "resource_group_name" {
  description = "Nome do Resource Group onde o AKS será criado"
  type        = string
}

variable "location" {
  description = "Localização do Azure onde o AKS será criado"
  type        = string
}

variable "dns_prefix" {
  description = "Prefixo DNS para o cluster AKS"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet onde o AKS será implantado"
  type        = string
}

# Optional variables with defaults (configuração econômica)
variable "node_count" {
  description = "Número de nós no cluster"
  type        = number
  default     = 1
  
  validation {
    condition     = var.node_count >= 1 && var.node_count <= 10
    error_message = "O número de nós deve estar entre 1 e 10."
  }
}

variable "vm_size" {
  description = "Tamanho da VM para os nós (econômico)"
  type        = string
  default     = "Standard_D2s_v3"
  
  validation {
    condition = contains([
      "Standard_B1s",
      "Standard_B2s", 
      "Standard_B1ms",
      "Standard_B2ms",
      "Standard_D2ps_v6",
      "Standard_D2s_v3"
    ], var.vm_size)
    error_message = "Use um tamanho de VM econômico (série B ou DS2_v2)."
  }
}

# Tags
variable "tags" {
  description = "Tags a serem aplicadas aos recursos"
  type        = map(string)
  default     = {}
}