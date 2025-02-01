variable "subnet-name" {
  description = "Name of the subnet"
  type        = string
  
}

variable "subnet-rg_name" {
  description = "Name of the resource group"
  type        = string
  
}

variable "vnet-name" {
  description = "Name of the virtual network"
  type        = string
  
}

variable "address" {
  description = "Address prefix of the subnet"
  type        = list(string)
  
}