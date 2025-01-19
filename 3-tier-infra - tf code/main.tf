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
  subscription_id = "baa3252d-06b9-4e1b-a961-2ebe0501976c"
}

variable "type" {
  description = "infra type"
  type        = string
  default     = "3-tier-infra"

}

module "rg" {
  source   = "./RG"
  rg_name  = "${var.type}-rg"
  location = "northeurope"
}

module "networking" {
  source                  = "./Networking"
  vnet_name               = "${var.type}-vnet"
  vnet_address_space      = ["24.0.0.0/20"]
  ag-subnet_name          = "${var.type}-ag-subnet"
  ag-subnet_address       = ["24.0.2.0/24"]
  frontend-subnet_name    = "${var.type}-frontend-subnet"
  frontend-subnet_address = ["24.0.3.0/24"]
  backend-subnet_name     = "${var.type}-backend-subnet"
  backend-subnet_address  = ["24.0.4.0/24"]
  db-subnet_name          = "${var.type}-db-subnet"
  firewall-subnet_address = ["24.0.6.0/25"]
  firewall-subnet_name    = "AzureFirewallSubnet"
  location                = module.rg.location
  rg_name                 = module.rg.rg_name
}

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

module "frontend-vm" {
  source         = "./VM"
  vm_name        = "frontend-vm"
  location       = module.rg.location
  rg_name        = module.rg.rg_name
  admin_username = "3tieruser"
  admin_password = "3@tieruserpw"
  nic-id         = module.public-nic.nic_id
}

module "backend-vm" {
  source         = "./VM"
  vm_name        = "backend-vm"
  location       = module.rg.location
  rg_name        = module.rg.rg_name
  admin_username = "3tieruser"
  admin_password = "3@tieruserpw"
  nic-id         = module.backend-private-nic.private-nic-id
}

module "db-vm" {
  source         = "./VM"
  vm_name        = "db-vm"
  location       = module.rg.location
  rg_name        = module.rg.rg_name
  admin_username = "3tieruser"
  admin_password = "3@tieruserpw"
  nic-id         = module.db-private-nic.private-nic-id
}

module "app-gateway" {
  source             = "./application-gateway and WAF"
  config             = "app-gateway"
  ag_name            = "${var.type}-ag"
  rg_name            = module.rg.rg_name
  location           = module.rg.location
  subnet_id          = module.networking.app-gateway-id
  private-ip-address = module.frontend-vm.private-ip
}

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

module "firewall" {
  source     = "./firewall"
  fw-ip-name = "${var.type}-fw-ip"
  location   = module.rg.location
  rg_name    = module.rg.rg_name
  fw-name    = "${var.type}-fw"
  subnet_id  = module.networking.firewall-subnet-id

}