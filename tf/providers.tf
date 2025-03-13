terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.22.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.1.0"
    }

  }
  backend "azurerm" {
    # These values will be filled by GitHub Actions
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

provider "azuread" {
  # Configuration options
}