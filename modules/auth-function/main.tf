data "azurerm_client_config" "current" {}

resource "azurerm_service_plan" "fastfood_service_plan" {
  name                = "fastfood-app-service-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "Y1"
  os_type             = "Linux"
}

resource "azurerm_linux_function_app" "fastfood_auth_function" {
  name                = var.function_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.fastfood_service_plan.id

  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.func_identity.id]
  }

  key_vault_reference_identity_id = azurerm_user_assigned_identity.func_identity.id

  site_config {
    health_check_path = "/health"
    health_check_eviction_time_in_min = 2
    application_stack {
      dotnet_version = "8.0"
      use_dotnet_isolated_runtime = true
    }
  }

  app_settings = {
    "AZURE_SQL_CONNECTIONSTRING" = "@Microsoft.KeyVault(SecretUri=${var.database_connection_secret_uri})"
    "SECRET_KEY_PASSWORD" = "@Microsoft.KeyVault(SecretUri=${var.secret_key_secret_uri})"
    "SALT_KEY_PASSWORD" = "@Microsoft.KeyVault(SecretUri=${var.salt_key_secret_uri})"
  }

  tags = var.tags
}

resource "azurerm_user_assigned_identity" "func_identity" { 
  name = "func-identity" 
  location = var.location 
  resource_group_name = var.resource_group_name 
}

resource "azurerm_key_vault_access_policy" "function_app" {
  key_vault_id = var.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.func_identity.principal_id

  secret_permissions = ["Get", "List"]
}