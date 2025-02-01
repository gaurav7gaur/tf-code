resource "azurerm_network_security_group" "nsg" {
  name = var.nsg-name
  location = var.location
  resource_group_name = var.rg_name
}
/*
resource "azurerm_network_security_group" "backend-nsg" {
  name = var.backend-nsg_name
  location = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_network_security_group" "db-nsg" {
  name = var.db-nsg_name
  location = var.location
  resource_group_name = var.rg_name
}
*/



resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id = var.subnet-id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

/*
resource "azurerm_subnet_network_security_group_association" "nsg_association-backend" {
  subnet_id = var.backend-subnet_id
  network_security_group_id = azurerm_network_security_group.backend-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_association-db" {
  subnet_id = var.db-subnet_id
  network_security_group_id = azurerm_network_security_group.db-nsg.id
}

*/