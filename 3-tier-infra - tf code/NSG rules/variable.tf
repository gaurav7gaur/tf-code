variable "rg_name" {
  description = "Name of the resource group"
  
}

variable "frontend-nsg_name" {
  description = "Name of the frontend NSG"
  
}

variable "ag-public-ip_name" {
  description = "Name of the application gateway public IP"
  
}

variable "frontend-vm-private-ip" {
  description = "Private IP address of the frontend VM"
  
}

variable "frontend-subnet_address" {
  description = "Address space of the frontend subnet"
  
}

variable "backend-subnet_address" {
  description = "Address space of the backend subnet"
  
}

variable "backend-nsg_name" {
  description = "Name of the backend NSG"
  
}

variable "db-subnet_address" {
  description = "Address space of the database subnet"
  
}

variable "db-nsg-name" {
  description = "Name of the database NSG"
  
}