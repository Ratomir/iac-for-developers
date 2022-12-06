# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.34.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "2.31.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-sin22-shared"
    storage_account_name = "stsin22v1state"
    container_name       = "sin22v3state"
    key                  = "terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

provider "azuread" {
  # Configuration options

  tenant_id = var.tenant_id
}

provider "random" {
  # Configuration options
}
