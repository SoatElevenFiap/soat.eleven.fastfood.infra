# AKS Cluster outputs essenciais
output "cluster_id" {
  description = "ID do cluster AKS"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "cluster_name" {
  description = "Nome do cluster AKS"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "cluster_fqdn" {
  description = "FQDN do cluster AKS"
  value       = azurerm_kubernetes_cluster.aks.fqdn
}

output "kube_config" {
  description = "Configuração completa do kubectl"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "cluster_identity" {
  description = "Identidade gerenciada do cluster"
  value = {
    principal_id = azurerm_kubernetes_cluster.aks.identity[0].principal_id
    tenant_id    = azurerm_kubernetes_cluster.aks.identity[0].tenant_id
    type         = azurerm_kubernetes_cluster.aks.identity[0].type
  }
}

output "node_resource_group" {
  description = "Nome do resource group dos nós"
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}