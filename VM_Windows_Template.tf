# Create Network Interface Card

resource "azurerm_network_interface" "Nic" {
  name                = "Terraform_Windows_Nic"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "Terraform_Internal_IP"
    subnet_id                     = azurerm_subnet.VSubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create Windows Virtual Machine

resource "azurerm_windows_virtual_machine" "VM" {
  name                  = "Terraform-Windows-VM"
  location              = azurerm_resource_group.RG.location
  resource_group_name   = azurerm_resource_group.RG.name
  size                  = "Standard_F2"
  admin_username        = "EnvelopAdmin"
  admin_password        = "ThisismyPassword!@#"
  network_interface_ids = [azurerm_network_interface.Nic.id]
  computer_name         = "Terraform-Windows-VM"

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}