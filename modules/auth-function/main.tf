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

  connection_string {
    name = var.database_name
    type = "PostgreSQL"
    value = var.connection_string_database
  }

  site_config {
    health_check_path = "/health"
    application_stack {
      dotnet_version = "8.0"
      use_dotnet_isolated_runtime = true
    }
  }

  app_settings = {
    AZURE_SQL_CONNECTIONSTRING = var.connection_string_database
    SALT_KEY_PASSWORK = "LhC2w472LWXN0/RMkp65Yw=="
    SECRET_KEY_PASSWORK = "5180e58ff93cef142763fdf3cc11f36c16335292a69bf201a4f72a834e625038032d04823966b02ff320564a0bc677c4bdcf3d67be724879b33711b04ba3e337"
  }

  tags = var.tags
}

//https://learn.microsoft.com/en-us/azure/azure-functions/functions-add-output-binding-azure-sql-vs-code?pivots=programming-language-csharp