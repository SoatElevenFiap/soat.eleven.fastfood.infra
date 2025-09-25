# =================
# Configuração Principal - SOAT Eleven Fast Food
# Infraestrutura Simplificada e Econômica para Pós-graduação
# =================

# Configurações do Resource Group
resource_group_name = "rg-fastfood-postech"
location            = "Brazil South" # Região principal

# Tags para identificação de recursos
tags = {
  Environment = "Development"
  Project     = "SOAT-FastFood"
  Course      = "PosGraduacao-ArquiteturaSoftware"
  Purpose     = "Learning"
}

# =================
# Configuração VNet - Necessário para Application Gateway
# =================
create_gateway_subnet       = false           # Gateway Subnet para VPN (não necessário)
enable_container_delegation = false           # Desabilitado para compatibilidade com AKS
app_gateway_subnet_prefixes = ["10.0.3.0/24"] # Subnet dedicada para Application Gateway

# =================
# Configuração AKS (Kubernetes) - Configuração Econômica
# =================
aks_cluster_name       = "aks-fastfood-postech"
aks_node_count         = 1                 # Mínimo para economia
aks_vm_size            = "Standard_D2s_v3" # SKU mais econômico
aks_kubernetes_version = "1.28.3"          # Versão estável
aks_network_plugin     = "kubenet"         # Plugin de rede mais simples

# =================
# Configuração Application Gateway - Configuração Econômica
# =================
app_gateway_name        = "agw-fastfood-postech"
app_gateway_sku_name    = "Standard_v2" # SKU atualizado (v1 deprecado)
app_gateway_sku_tier    = "Standard_v2" # Tier atualizado
app_gateway_capacity    = 1             # Capacidade mínima
app_gateway_backend_ips = []            # Será configurado após deploy do AKS

# =================
# Configuração PostgreSQL - Configuração Econômica
# =================
postgresql_server_name           = "psql-fastfood-postech-001"
postgresql_version               = "14"
postgresql_sku_name              = "B_Standard_B1ms" # SKU mais econômico
postgresql_storage_mb            = 32768             # 32GB - mínimo
postgresql_backup_retention_days = 7                 # Mínimo para economia
postgresql_database_name         = "fastfood"
