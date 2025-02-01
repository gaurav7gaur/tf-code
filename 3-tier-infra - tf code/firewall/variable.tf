variable "fw-ip-name" {
  description = "Name of the firewall IP"
  type        = string
  default     = "firewall"
  
}

variable "location" {
  description = "Location of the firewall"
  type        = string
  default     = "northeurope"
  
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
  default     = "firewall-rg"
  
}

variable "fw-name" {
  description = "Name of the firewall"
  type        = string
  default     = "firewall"
  
}

variable "subnet_id" {
  description = "ID of the firewall subnet"
  type        = string
  
}

variable "sku-name" {
  description = "SKU name of the firewall"
  type        = string
  default     = "AZFW_VNet"
  
}

variable "sku-tier" {
  description = "SKU tier of the firewall"
  type        = string
  default     = "Standard"
  
}