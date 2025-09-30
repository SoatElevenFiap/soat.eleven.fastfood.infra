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

# Nota: Role assignment AKS -> ACR é criado no main.tf para evitar dependências circulares