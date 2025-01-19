resource "azurerm_windows_virtual_machine" "vm" {
  name = var.vm_name
  location = var.location
  resource_group_name = var.rg_name
  size = "Standard_DS1_v2"
  admin_username = var.admin_username
    admin_password = var.admin_password
    vm_agent_platform_updates_enabled = true
    network_interface_ids = [var.nic-id]
    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
      source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}