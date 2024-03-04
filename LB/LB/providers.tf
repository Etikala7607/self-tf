terraform {
  required_version = ">= 1.2"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  client_id       = "03f89f03-33ff-492a-8677-10e65f7640bb"
  client_secret   = "yJj8Q~HHk20m4X7P9DmD~ygf1.9-gPukL6dSwbMP"
  tenant_id       = "aa2d4a1b-a1ee-4883-ba04-3e8e5b9c70bc"
  subscription_id = "7f2b7f9a-240e-4173-884e-ba25fa5fa24d"
}