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

# Create a Resource Group

resource "azurerm_resource_group" "RG" {
  name     = "Terraform_ResourceGroup"
  location = "East US"
}

# Create a Virtual Network

resource "azurerm_virtual_network" "VNet" {
  name                = "Terraform_VNet"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  address_space       = ["192.168.0.0/16"]
  dns_servers         = ["192.168.0.5"]
}

#) Create Subnent

resource "azurerm_subnet" "VSubnet" {
  name                 = "Terraform_VSubnet"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.VNet.name
  address_prefixes     = ["192.168.10.0/24"]
}