resource "azurerm_public_ip" "gateway-ip" {
  name                = "ag--public-ip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  
}


locals {
  backend_address_pool_name      = "${var.config}-beap"
  frontend_port_name             = "${var.config}-feport"
  frontend_ip_configuration_name = "${var.config}-feip"
  http_setting_name              = "${var.config}-be-htst"
  listener_name                  = "${var.config}-httplstn"
  request_routing_rule_name      = "${var.config}-rqrt"
  redirect_configuration_name    = "${var.config}-rdrcfg"
}

resource "azurerm_application_gateway" "app-gateway" {
  name                = var.ag_name
  resource_group_name = var.rg_name
  location            = var.location

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "ag-ip-config"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.gateway-ip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
    ip_addresses = [var.private-ip-address]
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    #path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    priority                   = 10
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  waf_configuration {
    enabled = true
    firewall_mode = "Prevention"
    rule_set_type = "OWASP"
    rule_set_version = "3.0"
  }
}