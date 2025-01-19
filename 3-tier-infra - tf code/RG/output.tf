output "rg_name" {
  value = azurerm_resource_group.rg.name
  description = "value of the resource group name"
}

output "location" {
  value = azurerm_resource_group.rg.location
  description = "value of the location"
  
}