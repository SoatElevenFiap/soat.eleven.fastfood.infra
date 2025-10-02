terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.100.0"
    }

    # Provedor TIME (Necessário para time_sleep)
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9" # A versão "~> 0.9" garante a versão mais recente da série 0.9
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}