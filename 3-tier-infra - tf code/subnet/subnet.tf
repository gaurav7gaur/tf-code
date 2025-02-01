resource "azurerm_subnet" "subnet" {
  name                 = var.subnet-name
  resource_group_name = var.subnet-rg_name
  virtual_network_name = var.vnet-name
  address_prefixes     = var.address
}