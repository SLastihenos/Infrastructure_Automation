# Create Network Interface Card

resource "azurerm_network_interface" "LNic" {
  name                = "Terraform_Linux_Nic"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "Terraform_Internal_Linux_IP"
    subnet_id                     = azurerm_subnet.VSubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create Linux Virtual Machine

resource "azurerm_linux_virtual_machine" "LinuxVM" {
  name                            = "Terraform-Linux-VM"
  location                        = azurerm_resource_group.RG.location
  resource_group_name             = azurerm_resource_group.RG.name
  size                            = "Standard_F2"
  admin_username                  = "EnvelopAdmin"
  admin_password                  = "ThisismyPassword!@#"
  network_interface_ids           = [azurerm_network_interface.LNic.id]
  computer_name                   = "Terraform-Linux-VM"
  disable_password_authentication = false

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}




