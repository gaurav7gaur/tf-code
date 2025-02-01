variable "rg_name" {
  description = "Name of the resource group"
  
}

variable "nsg-name" {
  description = "Name of the NSG"
  
}

variable "name" {
  description = "Name of the NSG rule"
  type = string
}

variable "priority" {
  description = "Priority of the rule"
  type        = number
  
}

variable "direction" {
  description = "Direction of the rule"
  type        = string
  
}

variable "access" {
  description = "Access of the rule"
  type        = string
  
}

variable "protocol" {
  description = "Protocol of the rule"
  type        = string
  
}
variable "source_port_range" {
  description = "Source port of the rule"
  type        = string
  
}
variable "destination_port_range" {
  description = "Destination port of the rule"
  type        = string
  
}
variable "source_address_prefix" {
  description = "Source address of the rule"
  type        = string
  
}
variable "destination_address_prefix" {
  description = "Destination address of the rule"
  type        = string
  
}



/*
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
*/