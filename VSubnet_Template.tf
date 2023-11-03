#) Create Subnent

resource "azurerm_subnet" "VSubnet2" {
  name                 = "Terraform_VSubnet2"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.VNet.name
  address_prefixes     = ["192.168.20.0/24"]
}
