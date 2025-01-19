output "frontend-subnet-id" {
  value = azurerm_subnet.frontend-subnet.id
    description = "value of the frontend subnet id"
}

output "backend-subnet-id" {
  value = azurerm_subnet.backend-subnet.id
    description = "value of the backend subnet id"
  
}

output "db-subnet-id" {
  value = azurerm_subnet.db-subnet.id
    description = "value of the db subnet id"
  
}

output "app-gateway-id" {
  value = azurerm_subnet.application-gateway-subnet.id
    description = "value of the application gateway subnet id"
  
}

output "frontend-subnet-address" {
  value = azurerm_subnet.frontend-subnet.address_prefixes
    description = "value of the frontend subnet address"
  
}

output "backend-subnet-address" {
  value = azurerm_subnet.backend-subnet.address_prefixes
    description = "value of the backend subnet address"
  
}

output "db-subnet-address" {
  value = azurerm_subnet.db-subnet.address_prefixes
    description = "value of the db subnet address"
  
}

output "firewall-subnet-id" {
  value = azurerm_subnet.firewall-subnet.id
    description = "value of the firewall subnet id"
  
}