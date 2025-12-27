# =================
# Configuração Principal - SOAT Eleven Fast Food
# Infraestrutura Simplificada e Econômica para Pós-graduação
# =================

# Configurações do Resource Group
resource_group_name = "rg-fastfood-postech"
location            = "Canada Central" # Região principal

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
aks_vm_size            = "Standard_E2s_v3" # SKU mais econômico
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
# Configuração Redis - Configuração Econômica
# =================
redis_name                = "redis-fastfood-postech"
redis_capacity            = 0     # C0 (250MB) - mínimo para economia
redis_family              = "C"   # Basic/Standard (C) ou Premium (P)
redis_enable_non_ssl_port = false # Desabilitado por segurança
redis_minimum_tls_version = "1.2" # TLS 1.2 mínimo

# =================
# Configuração MongoDB - Container no AKS (Econômico)
# =================
mongodb_database_name = "fastfood" # Nome do banco que será criado no MongoDB container

# =================