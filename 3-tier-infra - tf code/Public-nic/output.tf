output "publicip_id" {
  value = azurerm_public_ip.publicip.id
}

output "nic_id" {
  value = azurerm_network_interface.nic.id
}