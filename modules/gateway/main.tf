# Public IP for Application Gateway
resource "azurerm_public_ip" "app_gateway" {
  name                = "${var.gateway_name}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

# Application Gateway - Configuração Simples e Econômica
resource "azurerm_application_gateway" "main" {
  name                = var.gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location

  # SKU mínimo para economia
  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.capacity
  }

  gateway_ip_configuration {
    name      = "gateway-ip-configuration"
    subnet_id = var.gateway_subnet_id
  }

  frontend_port {
    name = "frontend-port-80"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend-ip-config"
    public_ip_address_id = azurerm_public_ip.app_gateway.id
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip-config"
    frontend_port_name             = "frontend-port-80"
    protocol                       = "Http"
  }

  request_routing_rule {
    name               = "routing-rule"
    rule_type          = "PathBasedRouting"
    http_listener_name = "http-listener"
    priority           = 100
    url_path_map_name  = "url-path-map"
  }

  url_path_map {
    name                               = "url-path-map"
    default_backend_address_pool_name  = "backend-pool"
    default_backend_http_settings_name = "backend-http-settings"
    path_rule {
      name                       = "function-path"
      paths                      = ["/api/auth*"]
      backend_address_pool_name  = "auth-function-backend-pool"
      backend_http_settings_name = "auth-function-http-settings"
    }
  }

  //BACKEND
  backend_address_pool {
    name         = "backend-pool"
    ip_addresses = var.backend_ip_addresses
  }

  backend_http_settings {
    name                  = "backend-http-settings"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  //AUTH FUNCTION
  backend_address_pool {
    name  = "auth-function-backend-pool"
    fqdns = [var.function_app_hostname]
  }

  backend_http_settings {
    name                                = "auth-function-http-settings"
    port                                = 443
    path                                = "/"
    protocol                            = "Https"
    pick_host_name_from_backend_address = true
    cookie_based_affinity               = "Disabled"
    request_timeout                     = 60
  }

  ssl_policy {
    policy_name = "AppGwSslPolicy20220101" # Política TLS moderna
    policy_type = "Predefined"
  }

  tags = var.tags
}
