resource "azurerm_public_ip" "publicip" {
  name = "p-ip"
  location = var.location
  resource_group_name = var.rg_name
  allocation_method = "Dynamic"
  sku = "Basic"
 
}

resource "azurerm_network_interface" "nic" {
  name = "${var.vm_name}-nic"
    location = var.location
    resource_group_name = var.rg_name
    ip_configuration {
        name = "ipconfig"
        subnet_id = var.subnet_id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.publicip.id
    }
}
