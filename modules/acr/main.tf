# Azure Container Registry - Configuração Econômica para Estudantes
resource "azurerm_container_registry" "main" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location           = var.location
  sku                = var.sku_name
  admin_enabled      = var.admin_enabled

  # Acesso público habilitado para simplicidade (SKU Basic)
  public_network_access_enabled = var.public_network_access_enabled

  tags = var.tags
}

# Role assignment para AKS fazer pull das imagens
# Será criado apenas se o aks_principal_id for fornecido explicitamente
# Para primeira execução, deixe vazio e execute terraform apply duas vezes
resource "azurerm_role_assignment" "aks_acr_pull" {
  count                = var.aks_principal_id != null && var.aks_principal_id != "" ? 1 : 0
  principal_id         = var.aks_principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.main.id
  
  depends_on = [azurerm_container_registry.main]
}