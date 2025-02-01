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

variable "pip-name" {
    description = "Name of the public IP"
    type        = string
    default     = "pip"
  
}