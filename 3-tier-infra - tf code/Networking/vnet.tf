resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.vnet_address_space
  
}

resource "azurerm_subnet" "application-gateway-subnet" {
  name                 = var.ag-subnet_name
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.ag-subnet_address
  
}

resource "azurerm_subnet" "frontend-subnet" {
  name                 = var.frontend-subnet_name
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.frontend-subnet_address
  
}

resource "azurerm_subnet" "backend-subnet" {
  name                 = var.backend-subnet_name
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.backend-subnet_address
  
}

resource "azurerm_subnet" "db-subnet" {
  name                 = var.db-subnet_name
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.db-subnet_address
  
}


resource "azurerm_subnet" "firewall-subnet" {
  name                 = var.firewall-subnet_name
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.firewall-subnet_address
  
}