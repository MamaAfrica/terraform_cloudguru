terraform {
  required_version = ">=1.3.0"
  required_providers {
    azurerm = {
      "source" = "hashicorp/azurerm"
      version  = ">=3.94.0"
    }
  }
  cloud {
    organization = "mamaafrica"

    workspaces {
      name = "cd_azure_cloud_guru"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

resource "random_string" "uniquestring" {
  length  = 3
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg" {
  name     = "813-6d290350-hands-on-with-terraform-on-azure"
  location = "East US"
}
module "storageacc" {
  source                  = "app.terraform.io/mamaafrica/storageacc/azurerm"
  version                 = "1.0.0"
  storage_account_name    = "mimistorage${random_string.uniquestring.result}"
  resource_group_name     = azurerm_resource_group.rg.name
  resource_group_location = azurerm_resource_group.rg.location
  Environment             = "Production"
}

