resource "azurerm_network_security_rule" "rule" {
  name                        = var.name
  priority                    = var.priority
  direction                   = var.direction
  access                      = var.access
  protocol                    = var.protocol
  source_port_range           = var.source_port_range
  destination_port_range      = var.destination_port_range
  source_address_prefix       = var.source_address_prefix
  destination_address_prefix  = var.destination_address_prefix
  resource_group_name         = var.rg_name
  network_security_group_name = var.nsg-name
}

/*
resource "azurerm_network_security_rule" "frontend-rule1" {
  name                        = "ag-to-frontend-vm-port80"
  priority                    = 130
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = var.ag-public-ip_name
  destination_address_prefix  = var.frontend-vm-private-ip
  resource_group_name         = var.rg_name
  network_security_group_name = var.frontend-nsg_name
}

resource "azurerm_network_security_rule" "frontend-rule2" {
  name                        = "my-laptop-to-frontend-vm"
  priority                    = 140
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "49.36.144.215"
  destination_address_prefix  = var.frontend-vm-private-ip
  resource_group_name         = var.rg_name
  network_security_group_name = var.frontend-nsg_name
}

resource "azurerm_network_security_rule" "frontend-rule3" {
  name                        = "denyall"
  priority                    = 147
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = var.frontend-subnet_address[0]
  resource_group_name         = var.rg_name
  network_security_group_name = var.frontend-nsg_name
}


resource "azurerm_network_security_rule" "backend-rule1" {
  name                        = "allow-frontend-to-backend"
  priority                    = 141
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = var.frontend-subnet_address[0]
  destination_address_prefix  = var.backend-subnet_address[0]
  resource_group_name         = var.rg_name
  network_security_group_name = var.backend-nsg_name
}

resource "azurerm_network_security_rule" "backend-rule2" {
  name                        = "allow-db-to-backend"
  priority                    = 142
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = var.db-subnet_address[0]
  destination_address_prefix  = var.backend-subnet_address[0]
  resource_group_name         = var.rg_name
  network_security_group_name = var.backend-nsg_name
}

resource "azurerm_network_security_rule" "backend-rule3" {
  name                        = "denyall"
  priority                    = 151
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = var.backend-subnet_address[0]
  resource_group_name         = var.rg_name
  network_security_group_name = var.backend-nsg_name
}

resource "azurerm_network_security_rule" "db-rule1" {
  name                        = "backend-to-db"
  priority                    = 143
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = var.backend-subnet_address[0]
  destination_address_prefix  = var.db-subnet_address[0]
  resource_group_name         = var.rg_name
  network_security_group_name = var.db-nsg-name
}

resource "azurerm_network_security_rule" "db-rule2" {
  name                        = "denyall"
  priority                    = 155
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = var.db-subnet_address[0]
  resource_group_name         = var.rg_name
  network_security_group_name = var.db-nsg-name
}

*/