output "subnet-id" {
  value = azurerm_subnet.subnet.id
    description = "value of the subnet id"
  
}

output "address-prefix" {
  value = azurerm_subnet.subnet.address_prefixes
    description = "value of the subnet address"
  
}