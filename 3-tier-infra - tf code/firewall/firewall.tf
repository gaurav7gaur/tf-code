resource "azurerm_public_ip" "firewall-pip" {
  name = var.fw-ip-name
  location = var.location
    resource_group_name = var.rg_name
    allocation_method = "Static"
    sku                 = "Standard"
}

resource "azurerm_firewall" "firewall" {
  name                = var.fw-name
  location            = var.location
  resource_group_name = var.rg_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.firewall-pip.id
  }
}