/*
terraform {
  cloud {
    organization = "EnvelopTechnologies"

    workspaces {
      name = "Infrastructure_Automation_Project_Test"
    }
  }
}
*/
# Install tools for Azure APIs

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.76.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

# Set Variables

variable "VNet1_Name" {
  description = "Name for VNet1"
  type = string
}

variable "VNet1_Address_Space" {
  description = "Address Space for the Virtual Network"                
}

variable "VNet1_DNS_Servers" {
  description = "DNS Server/s for VNet1"
}

variable "VSubnet1_Name" {
  description = "Name for VSubnet1"
  type = string
}

variable "VSubnet1_Address_Prefix" {
  description = "Address Prefix for VSubnet1"
 }

variable "Nic1_Name" {
  description = "Name for Nic1"
  type = string
}

variable "Nic1_Private_IP_Address_Allocation" {
  description = "Private IP Address Allocation for Nic1"
  type = string
}

variable "VM1_Name" {
  description = "Name for VM1"
  type = string
}

variable "VM1_Size" {
  description = "VM1 Size (Standard_B1, Standard_F2, etc)"
  type = string
}

variable "VM1_Admin_Username" {
  description = "VM1 Admin Usernam"
  type = string   
}  

variable "VM1_Admin_Password" {
  description = "VM1 Admin Password"
  type = string 
  }

variable "VM1_Storage_Account_Type" {
  description = "Storage Account Type for VM1 (Standard_LRS, Standard_ZRS, etc)"
  type = string
}

variable "VM1_Caching" {
  description = "VM1 Caching (R,RW,W)"
  type = string  
}

variable "VM1_Source_Image_Publisher" {
  description = "Source Image Publisher for VM1 (MicrosoftWindowsServer, Debian, OpenLogic, etc)"
  type = string
}

variable "VM1_Source_Image_Offer" {
  description = "Source Image Offer for VM1 (WindowsServer, debian-11, CentosOS, etc)"
  type = string
}

variable "VM1_Source_Image_SKU" {
  description = "Source Image SKU for VM1 (2016-Datacenter, 11-backports-gen2, 8_5-gen2, etc)"
  type = string
}

# Step 1) Create a Resource Group

resource "azurerm_resource_group" "RG1" {
  name = "Terraform_Resource_Group"
  location = "East US"
}

# Step 2) Create a Virtual Network

resource "azurerm_virtual_network" "VNet1" {
  name = var.VNet1_Name
  location = azurerm_resource_group.RG1.location
  resource_group_name = azurerm_resource_group.RG1.name
  address_space = [var.VNet1_Address_Space]
  dns_servers = [var.VNet1_DNS_Servers]
}

# Step 3) Create Subnent

resource "azurerm_subnet" "VSubnet1" {
  name = var.VSubnet1_Name
  resource_group_name = azurerm_resource_group.RG1.name
  virtual_network_name = azurerm_virtual_network.VNet1.name
  address_prefixes = [var.VSubnet1_Address_Prefix]
}

# Step 4) Create Network Interface

resource "azurerm_network_interface" "Nic1" {
  name = var.Nic1_Name
  location = azurerm_resource_group.RG1.location
  resource_group_name = azurerm_resource_group.RG1.name

  ip_configuration {
    name = "Terraform_Internal_IP"
    subnet_id = azurerm_subnet.VSubnet1.id
    private_ip_address_allocation = var.Nic1_Private_IP_Address_Allocation
  }
}

# Step 5) Create a Virtual Machine

resource "azurerm_windows_virtual_machine" "VM1" {
  name = var.VM1_Name
  location = azurerm_resource_group.RG1.location
  resource_group_name = azurerm_resource_group.RG1.name
  size = var.VM1_Size
  admin_username = var.VM1_Admin_Username
  admin_password = var.VM1_Admin_Password
  network_interface_ids = [ azurerm_network_interface.Nic1.id ]
  computer_name = var.VM1_Name
  os_disk {
    storage_account_type = var.VM1_Storage_Account_Type
    caching = var.VM1_Caching
  }

  source_image_reference {
    publisher = var.VM1_Source_Image_Publisher
    offer = var.VM1_Source_Image_Offer
    sku = var.VM1_Source_Image_SKU
    version = "latest"
  }
}




