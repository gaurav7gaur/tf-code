terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.16.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
  subscription_id = "4d14920f-f57e-4470-8ba0-04827bfd7f03"
  //subscription_id = "baa3252d-06b9-4e1b-a961-2ebe0501976c"
}

variable "type" {
  description = "infra type"
  type        = string
  default     = "3-t-i"

}

variable "admin_password" {
  description = "admin password"
  type        = string
  sensitive   = true

}

module "rg" {
  source   = "./RG"
  rg_name  = "${var.type}-rg"
  location = "northeurope"
}

module "networking" {
  source             = "./Networking"
  vnet_name          = "${var.type}-vnet"
  vnet_address_space = ["24.0.0.0/20"]
  /*ag-subnet_name          = "${var.type}-ag-subnet"
  ag-subnet_address       = ["24.0.2.0/24"]
  frontend-subnet_name    = "${var.type}-frontend-subnet"
  frontend-subnet_address = ["24.0.3.0/24"]
  backend-subnet_name     = "${var.type}-backend-subnet"
  backend-subnet_address  = ["24.0.4.0/24"]
  db-subnet_name          = "${var.type}-db-subnet"
  firewall-subnet_address = ["24.0.6.0/25"]
  firewall-subnet_name    = "AzureFirewallSubnet"
  */
  location = module.rg.location
  rg_name  = module.rg.rg_name
}

module "ag-subnet" {
  source         = "./subnet"
  subnet-name    = "${var.type}-ag-subnet"
  subnet-rg_name = module.rg.rg_name
  vnet-name      = module.networking.vnet_name
  address        = ["24.0.2.0/24"]
}

module "frontend-subnet" {
  source         = "./subnet"
  subnet-name    = "${var.type}-frontend-subnet"
  subnet-rg_name = module.rg.rg_name
  vnet-name      = module.networking.vnet_name
  address        = ["24.0.3.0/24"]
}

module "backend-subnet" {
  source         = "./subnet"
  subnet-name    = "${var.type}-backend-subnet"
  subnet-rg_name = module.rg.rg_name
  vnet-name      = module.networking.vnet_name
  address        = ["24.0.4.0/24"]
}

module "db-subnet" {
  source         = "./subnet"
  subnet-name    = "${var.type}-db-subnet"
  subnet-rg_name = module.rg.rg_name
  vnet-name      = module.networking.vnet_name
  address        = ["24.0.5.0/24"]
}

module "firewall-subnet" {
  source = "./subnet"
  subnet-name = "AzureFirewallSubnet"
  subnet-rg_name = module.rg.rg_name
  vnet-name = module.networking.vnet_name
  address = ["24.0.6.0/25"]
}



// ---------------------Old code: No Longer required---------------------
/*
module "NSG" {
  source             = "./NSGs"
  frontend-nsg_name  = "${var.type}-frontend-nsg"
  backend-nsg_name   = "${var.type}-backend-nsg"
  db-nsg_name        = "${var.type}-db-nsg"
  location           = module.rg.location
  rg_name            = module.rg.rg_name
  frontend-subnet_id = module.networking.frontend-subnet-id
  backend-subnet_id  = module.networking.backend-subnet-id
  db-subnet_id       = module.networking.db-subnet-id
}
*/

module "frontend-nsg" {
  source    = "./NSGs"
  nsg-name  = "${var.type}-frontend-nsg"
  location  = module.rg.location
  rg_name   = module.rg.rg_name
  subnet-id = module.frontend-subnet.subnet-id
}


module "backend-nsg" {
  source    = "./NSGs"
  nsg-name  = "${var.type}-backend-nsg"
  location  = module.rg.location
  rg_name   = module.rg.rg_name
  subnet-id = module.backend-subnet.subnet-id
}

module "db-nsg" {
  source    = "./NSGs"
  nsg-name  = "${var.type}-db-nsg"
  location  = module.rg.location
  rg_name   = module.rg.rg_name
  subnet-id = module.db-subnet.subnet-id
}

// ---------------------Old code: No Longer required---------------------
/*
module "public-nic" {
  source    = "./Public-nic"
  location  = module.rg.location
  rg_name   = module.rg.rg_name
  subnet_id = module.networking.frontend-subnet-id
}

module "backend-private-nic" {
  source    = "./Private-nic"
  location  = module.rg.location
  rg_name   = module.rg.rg_name
  vm_name   = "backend-vm"
  subnet_id = module.networking.backend-subnet-id
}

module "db-private-nic" {
  source    = "./Private-nic"
  location  = module.rg.location
  rg_name   = module.rg.rg_name
  vm_name   = "db-vm"
  subnet_id = module.networking.db-subnet-id
}
*/

module "vm-pip" {
  source   = "./public-ip"
  pip-name = "pip-front"
  rg_name  = module.rg.rg_name
  location = module.rg.location
}

module "frontend-vm" {
  source         = "./VM"
  vm_name        = "frontend-vm"
  location       = module.rg.location
  rg_name        = module.rg.rg_name
  admin_username = "3tieruser"
  admin_password = var.admin_password // "3@tieruserpw"
  pip-id         = module.vm-pip.pip-id
  subnet-id      = module.frontend-subnet.subnet-id
  //nic-id         = module.public-nic.nic_id
}

module "backend-vm" {
  source         = "./VM"
  vm_name        = "backend-vm"
  location       = module.rg.location
  rg_name        = module.rg.rg_name
  subnet-id      = module.backend-subnet.subnet-id
  admin_username = "3tieruser"
  admin_password = var.admin_password // "3@tieruserpw"
  //nic-id         = module.backend-private-nic.private-nic-id
}

module "db-vm" {
  source         = "./VM"
  vm_name        = "db-vm"
  location       = module.rg.location
  rg_name        = module.rg.rg_name
  subnet-id      = module.db-subnet.subnet-id
  admin_username = "3tieruser"
  admin_password = var.admin_password // "3@tieruserpw"
  //nic-id         = module.db-private-nic.private-nic-id
}

module "app-gateway" {
  source             = "./application-gateway and WAF"
  config             = "app-gateway"
  ag_name            = "${var.type}-ag"
  rg_name            = module.rg.rg_name
  location           = module.rg.location
  subnet_id          = module.ag-subnet.subnet-id
  private-ip-address = module.frontend-vm.private-ip
}


// ---------------------Old code: No Longer required---------------------
/*
module "nsg_rules" {
  source                  = "./NSG rules"
  rg_name                 = module.rg.rg_name
  frontend-nsg_name       = module.NSG.frontend-nsg-name
  backend-nsg_name        = module.NSG.backend-nsg-name
  db-nsg-name             = module.NSG.db-nsg-name
  ag-public-ip_name       = module.app-gateway.app-gate-public-ip
  frontend-vm-private-ip  = module.frontend-vm.private-ip
  frontend-subnet_address = module.networking.frontend-subnet-address
  backend-subnet_address  = module.networking.backend-subnet-address
  db-subnet_address       = module.networking.db-subnet-address
}
*/

module "nsg-frontend-rule1" {
  source                     = "./NSG rules"
  rg_name                    = module.rg.rg_name
  nsg-name                   = module.frontend-nsg.nsg-name
  name                       = "ag-to-frontend-vm-port80"
  priority                   = 130
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "80"
  source_address_prefix      = module.app-gateway.app-gate-public-ip
  destination_address_prefix = module.frontend-vm.private-ip
}

module "nsg-frontend-rule2" {
  source                     = "./NSG rules"
  rg_name                    = module.rg.rg_name
  nsg-name                   = module.frontend-nsg.nsg-name
  name                       = "my-laptop-to-frontend-vm"
  priority                   = 140
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "3389"
  source_address_prefix      = "49.36.144.215"
  destination_address_prefix = module.frontend-vm.private-ip
}

module "nsg-frontend-rule3" {
  source                     = "./NSG rules"
  rg_name                    = module.rg.rg_name
  nsg-name                   = module.frontend-nsg.nsg-name
  name                       = "denyall"
  priority                   = 147
  direction                  = "Inbound"
  access                     = "Deny"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = "*"
  destination_address_prefix = module.frontend-subnet.address-prefix[0]
}

module "nsg-backend-rule1" {
  source                     = "./NSG rules"
  rg_name                    = module.rg.rg_name
  nsg-name                   = module.backend-nsg.nsg-name
  name                       = "allow-frontend-to-backend"
  priority                   = 141
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = module.frontend-subnet.address-prefix[0] // var.frontend-subnet_address[0]
  destination_address_prefix = module.backend-subnet.address-prefix[0]  // var.backend-subnet_address[0]

}

module "nsg-backend-rule2" {
  source                     = "./NSG rules"
  rg_name                    = module.rg.rg_name
  nsg-name                   = module.backend-nsg.nsg-name
  name                       = "allow-db-to-backend"
  priority                   = 142
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = module.db-subnet.address-prefix[0]      //var.db-subnet_address[0]
  destination_address_prefix = module.backend-subnet.address-prefix[0] //var.backend-subnet_address[0]
}

module "nsg-backend-rule3" {
  source                     = "./NSG rules"
  rg_name                    = module.rg.rg_name
  nsg-name                   = module.backend-nsg.nsg-name
  name                       = "denyall"
  priority                   = 151
  direction                  = "Inbound"
  access                     = "Deny"
  protocol                   = "*"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = "*"
  destination_address_prefix = module.backend-subnet.address-prefix[0] //var.backend-subnet_address[0]
}

module "nsg-db-rule1" {
  source                     = "./NSG rules"
  rg_name                    = module.rg.rg_name
  nsg-name                   = module.db-nsg.nsg-name
  name                       = "backend-to-db"
  priority                   = 143
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "*"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = module.backend-subnet.address-prefix[0] //var.backend-subnet_address[0]
  destination_address_prefix = module.db-subnet.address-prefix[0]      //var.db-subnet_address[0]

}

module "nsg-db-rule2" {
  source                     = "./NSG rules"
  rg_name                    = module.rg.rg_name
  nsg-name                   = module.db-nsg.nsg-name
  name                       = "denyall"
  priority                   = 155
  direction                  = "Inbound"
  access                     = "Deny"
  protocol                   = "*"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = "*"
  destination_address_prefix = module.db-subnet.address-prefix[0] //var.db-subnet_address[0]

}



module "firewall" {
  source     = "./firewall"
  fw-ip-name = "${var.type}-fw-ip"
  location   = module.rg.location
  rg_name    = module.rg.rg_name
  fw-name    = "${var.type}-fw"
  subnet_id  = module.firewall-subnet.subnet-id
  sku-name = "AZFW_VNet"
  sku-tier = "Standard"
}
