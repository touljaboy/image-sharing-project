terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.8.0"
    }
    cloudinit = {
      source = "hashicorp/cloudinit"
      version = "2.3.7-alpha.2"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "cloudinit" {
  # Configuration options
}