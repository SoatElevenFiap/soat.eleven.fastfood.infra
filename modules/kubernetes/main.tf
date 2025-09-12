# Azure Kubernetes Service (AKS) Module - Configuração Simples e Econômica
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  # Configuração mínima do node pool
  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
    
    # Network configuration
    vnet_subnet_id = var.subnet_id
  }

  # Identity configuration
  identity {
    type = "SystemAssigned"
  }

# Network profile simples usando kubenet (mais barato)
network_profile {
  network_plugin = "kubenet"
  pod_cidr       = "10.244.0.0/16" 
  service_cidr   = "10.240.0.0/16"
  dns_service_ip = "10.240.0.10"
}

  tags = var.tags
}

# Role assignment for AKS to access subnet
resource "azurerm_role_assignment" "aks_subnet" {
  scope                = var.subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}