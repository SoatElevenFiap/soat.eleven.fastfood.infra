# Azure Cache for Redis - Configuração Econômica para Estudantes
resource "azurerm_redis_cache" "main" {
  name                = var.redis_name
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = var.capacity
  family              = var.family
  sku_name            = "${var.family}_${var.capacity}"

  # Configuração de rede (subnet_id requer SKU Premium)
  # Para SKU Basic/Standard, usar firewall rules ao invés de VNet integration
  subnet_id = var.subnet_id

  # Configuração de acesso
  # Nota: enable_non_ssl_port foi removido - Redis sempre usa SSL/TLS nas versões recentes
  minimum_tls_version = var.minimum_tls_version

  # Configuração de persistência (desabilitado para economia)
  redis_configuration {
    maxmemory_reserved = var.maxmemory_reserved
    maxmemory_delta    = var.maxmemory_delta
    maxmemory_policy   = var.maxmemory_policy
  }

  tags = var.tags
}

# Firewall rule para permitir acesso da subnet de aplicação
# Nota: Para calcular o range de IPs de um CIDR, usamos cidrhost
resource "azurerm_redis_firewall_rule" "app_subnet" {
  count               = var.app_subnet_cidr != null ? 1 : 0
  name                = "AllowAppSubnet"
  redis_cache_name    = azurerm_redis_cache.main.name
  resource_group_name = var.resource_group_name
  # cidrhost calcula o primeiro IP (0) e último IP (-1) do range CIDR
  start_ip = cidrhost(var.app_subnet_cidr, 0)
  end_ip   = cidrhost(var.app_subnet_cidr, -1)

  depends_on = [azurerm_redis_cache.main]
}

