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


variable "vm_name" {
    description = "Name of the virtual machine"
    type        = string
    default     = "vm"
  
}

variable "subnet_id" {
    description = "ID of the subnet"
    type        = string
    default     = "subnet"
  
}