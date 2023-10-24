# Vitural Netowrk Variables

VNet1_Name = "Terraform_VNet1"
VNet1_Address_Space = "192.168.0.0/16"
VNet1_DNS_Servers = "192.168.0.5"

# Virtual Subnet Variables

VSubnet1_Name = "Terraform_Subnet1"
VSubnet1_Address_Prefix = "192.168.10.0/24"

# Network Interface Variables

Nic1_Name = "Terraform_Nic1"
Nic1_Private_IP_Address_Allocation = "Dynamic"

# Virtual Machine Variables

VM1_Name = "Terraform-VM1"
VM1_Size = "Standard_F2"
VM1_Admin_Username = "EnvelopAdmin"
VM1_Admin_Password = "ThisismyPassword!@#"
VM1_Storage_Account_Type = "Standard_LRS"
VM1_Caching = "ReadWrite"
VM1_Source_Image_Publisher = "MicrosoftWindowsServer"
VM1_Source_Image_Offer = "WindowsServer"
VM1_Source_Image_SKU = "2016-Datacenter"