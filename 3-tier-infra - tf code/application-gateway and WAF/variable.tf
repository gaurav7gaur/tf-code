variable "config" {
  description = "Name of the virtual network"
  type        = string
  default     = "vnet"
  
}

variable "ag_name" {
  description = "Name of the application gateway"
  type        = string
  default     = "ag"
  
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg"
  
}

variable "location" {
  description = "Location of the resource group"
  type        = string
  default     = "East US"
  
}

variable "subnet_id" {
  description = "ID of the subnet"
  type        = string
  default     = "subnet-id"
  
}

variable "private-ip-address" {
  description = "Private IP address of the VM"
  type        = string
  
}