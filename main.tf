# Create a resource group
resource "azurerm_resource_group" "rg-postech" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

# Virtual Network Module
module "vnet" {
  source = "./modules/vnet"

  # Configuração obrigatória
  vnet_name           = var.vnet_name
  resource_group_name = azurerm_resource_group.rg-postech.name
  location            = azurerm_resource_group.rg-postech.location

  # Configuração de rede
  address_space               = var.vnet_address_space
  app_subnet_prefixes         = var.app_subnet_prefixes
  db_subnet_prefixes          = var.db_subnet_prefixes
  app_gateway_subnet_prefixes = var.app_gateway_subnet_prefixes
  gateway_subnet_prefixes     = var.gateway_subnet_prefixes

  # Features opcionais
  create_gateway_subnet       = var.create_gateway_subnet
  enable_container_delegation = var.enable_container_delegation

  # Tags
  tags = merge(var.tags, {
    Environment = var.environment
    Project     = "FastFood-System"
    CreatedBy   = "Terraform"
    Module      = "VNet"
  })

  # Dependência explícita do Resource Group
  depends_on = [azurerm_resource_group.rg-postech]
}

# Kubernetes Module
module "kubernetes" {
  source = "./modules/kubernetes"

  # Configuração obrigatória
  cluster_name        = var.aks_cluster_name
  resource_group_name = azurerm_resource_group.rg-postech.name
  location            = azurerm_resource_group.rg-postech.location
  dns_prefix          = var.aks_dns_prefix
  subnet_id           = module.vnet.app_subnet_id

  # Configuração econômica
  node_count = var.aks_node_count
  vm_size    = var.aks_vm_size

  # Tags
  tags = merge(var.tags, {
    Environment = var.environment
    Project     = "FastFood-System"
    CreatedBy   = "Terraform"
    Module      = "AKS"
  })

  depends_on = [azurerm_resource_group.rg-postech, module.vnet]
}

# # Application Gateway Module
module "gateway" {
  source = "./modules/gateway"

  # Configuração obrigatória
  gateway_name        = var.app_gateway_name
  resource_group_name = azurerm_resource_group.rg-postech.name
  location            = azurerm_resource_group.rg-postech.location
  gateway_subnet_id   = module.vnet.app_gateway_subnet_id

  # Configuração econômica
  sku_name = var.app_gateway_sku_name
  sku_tier = var.app_gateway_sku_tier
  capacity = var.app_gateway_capacity

  # Backend IPs (será configurado após AKS)
  backend_ip_addresses  = var.app_gateway_backend_ips
  function_app_hostname = module.auth_function.function_default_hostname

  # Tags
  tags = merge(var.tags, {
    Environment = var.environment
    Project     = "FastFood-System"
    CreatedBy   = "Terraform"
    Module      = "ApplicationGateway"
  })

  depends_on = [azurerm_resource_group.rg-postech, module.vnet, module.auth_function]
}

# Storage Account para Azure Function
resource "azurerm_storage_account" "function_storage" {
  name                     = "stfastfoodfunction"
  resource_group_name      = azurerm_resource_group.rg-postech.name
  location                 = azurerm_resource_group.rg-postech.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = merge(var.tags, {
    Environment = var.environment
    Project     = "FastFood-System"
    CreatedBy   = "Terraform"
    Purpose     = "Function Storage"
  })
}

#Azure Function Module
module "auth_function" {
  source        = "./modules/auth-function"
  function_name = "fastfood-auth-function"

  storage_account_name       = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key

  resource_group_name = azurerm_resource_group.rg-postech.name
  location            = azurerm_resource_group.rg-postech.location

  key_vault_id                   = data.terraform_remote_state.database.outputs.key_vault_id
  database_connection_secret_uri = data.terraform_remote_state.database.outputs.database_secret_uri
  secret_key_secret_uri          = data.terraform_remote_state.database.outputs.secret_key_secret_uri
  salt_key_secret_uri            = data.terraform_remote_state.database.outputs.salt_key_secret_uri

  # Tags
  tags = merge(var.tags, {
    Environment = var.environment
    Project     = "FastFood-System"
    CreatedBy   = "Terraform"
    Module      = "AuthFunction"
  })

  depends_on = [azurerm_resource_group.rg-postech]
}

# Azure Container Registry Module
module "acr" {
  source = "./modules/acr"

  # Configuração obrigatória
  acr_name            = var.acr_name
  resource_group_name = azurerm_resource_group.rg-postech.name
  location            = azurerm_resource_group.rg-postech.location

  # Configuração econômica
  sku_name      = var.acr_sku_name
  admin_enabled = var.acr_admin_enabled

  # Integração com AKS será configurada em uma segunda execução
  # aks_principal_id = module.kubernetes.cluster_identity.principal_id

  # Tags
  tags = merge(var.tags, {
    Environment = var.environment
    Project     = "FastFood-System"
    CreatedBy   = "Terraform"
    Module      = "ACR"
  })

  depends_on = [azurerm_resource_group.rg-postech]
}

# Azure Key Vault Module
