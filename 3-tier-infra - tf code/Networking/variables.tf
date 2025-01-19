variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "vnet"

}

variable "vnet_address_space" {
  description = "Address space of the virtual network"
  type        = list(string)
  default     = ["24.0.0.0/20"]

}

variable "ag-subnet_name" {
  description = "Name of the application gateway subnet"
  type        = string
  default     = "application-gateway-subnet"
  
}

variable "ag-subnet_address" {
  description = "Address space of the application gateway subnet"
  type        = list(string)
  default     = ["24.0.2.0/24"]
  
}

variable "frontend-subnet_name" {
  description = "Name of the frontend subnet"
  type        = string
  default     = "frontend-subnet"
  
}

variable "frontend-subnet_address" {
  description = "Address space of the frontend subnet"
  type        = list(string)
  default     = ["24.0.3.0/24"]
  
}

variable "backend-subnet_name" {
  description = "Name of the backend subnet"
  type        = string
  default     = "backend-subnet"
  
}

variable "backend-subnet_address" {
  description = "Address space of the backend subnet"
  type        = list(string)
  default     = ["24.0.4.0/24"]
  
}

variable "db-subnet_name" {
  description = "Name of the database subnet"
  type        = string
  default     = "db-subnet"
  
}

variable "db-subnet_address" {
  description = "Address space of the database subnet"
  type        = list(string)
  default     = ["24.0.5.0/24"]
  
}

variable "location" {
  description = "Location of the resource group"
  type        = string
  default     = "northeurope"
  
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg"
  
}

variable "firewall-subnet_name" {
  description = "Name of the firewall subnet"
  type        = string
  default     = "firewall-subnet"
  
}

variable "firewall-subnet_address" {
  description = "Address space of the firewall subnet"
  type        = list(string)
  default     = ["24.0.6.0/24"]
  
}