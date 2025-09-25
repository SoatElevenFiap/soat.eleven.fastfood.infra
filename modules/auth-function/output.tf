output "function_name" {
  description = "The name of the Function App"
  value       = azurerm_linux_function_app.fastfood_auth_function.name
}

output "function_default_hostname" {
  description = "The default hostname of the Function App"
  value       = azurerm_linux_function_app.fastfood_auth_function.default_hostname
}

output "dotnet_version" {
  description = "The .NET version of the Function App"
  value       = azurerm_linux_function_app.fastfood_auth_function.site_config[0].application_stack[0].dotnet_version
}

output "function_publish_profile" {
  description = "The publish profile of the Function App"
  value       = azurerm_linux_function_app.fastfood_auth_function.site_credential[0].name
  sensitive   = true
}

output "function_publish_password" {
  description = "The publish password of the Function App"
  value       = azurerm_linux_function_app.fastfood_auth_function.site_credential[0].password
  sensitive   = true
}

output "function_scm_url" {
  description = "The SCM URL of the Function App"
  value       = "https://${azurerm_linux_function_app.fastfood_auth_function.name}.scm.azurewebsites.net"
}

