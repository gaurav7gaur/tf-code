resource "azurerm_public_ip" "publicip" {
  name = var.pip-name
  location = var.location
  resource_group_name = var.rg_name
  allocation_method = "Dynamic"
  sku = "Basic"
 
}