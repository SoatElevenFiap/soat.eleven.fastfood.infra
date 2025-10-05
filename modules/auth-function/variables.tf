# The name of the Function App
variable "function_name" {
    description = "The name of the Function App"
    type        = string
    default     = ""
}

# The name of the Runtime stack to use for the Function App. Example: 'dotnet-isolated'
variable "runtime_name" {
    description = "The runtime stack to use for the Function App. Example: 'dotnet-isolated', 'node', 'python', etc."
    type        = string
    default     = "dotnet-isolated"
}

# The version of the runtime stack to use for the Function App. Example: '8.0' for .NET 8
variable "runtime_version" {
    description = "The version of the runtime stack to use for the Function App. Example: '8.0' for .NET 8, '3.9' for Python 3.9, etc."
    type        = string
    default     = "8.0"
}

# Tags
variable "tags" {
  description = "Tags a serem aplicadas aos recursos"
  type        = map(string)
  default     = {}
}

# Storage Account Name
variable "storage_account_name" {
  description = "The name of the Storage Account to be used by the Function App"
  type        = string
  default     = ""
}

# Storage Account Access Key
variable "storage_account_access_key" {
  description = "The access key for the Storage Account to be used by the Function App"
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "Nome do Resource Group"
  type        = string
}

variable "location" {
  description = "Localização do Azure"
  type        = string
}

variable "key_vault_id" {
  description = "ID do Key Vault onde estão armazenado connection string do banco"
  type        = string
}

variable "database_connection_secret_uri" {
  description = "URI do segredo no Key Vault que contém a connection string do banco"
  type        = string
}