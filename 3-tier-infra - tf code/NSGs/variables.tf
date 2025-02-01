/*variable "frontend-nsg_name" {
  description = "Name of the network security group"
  type        = string
  default     = "nsg"
  
}
variable "backend-nsg_name" {
  description = "Name of the network security group"
  type        = string
  default     = "nsg"
  
}
variable "db-nsg_name" {
  description = "Name of the network security group"
  type        = string
  default     = "nsg"
  
}*/

variable "nsg-name" {
  description = "Name of the network security group"
  type        = string
  default     = "nsg"
  
}

variable "location" {
  description = "Location of the resources"
  type        = string
  default     = "northeurope"
  
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg"
  
}

variable "subnet-id" {
  description = "ID of the subnet"
  type        = string
  
}


/*
variable "frontend-subnet_id" {
  description = "ID of the subnet"
  type        = string
  
}
variable "backend-subnet_id" {
  description = "ID of the subnet"
  type        = string
  
}
variable "db-subnet_id" {
  description = "ID of the subnet"
  type        = string
  
}
*/