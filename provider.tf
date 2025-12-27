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
  # Autenticação via Service Principal usando variáveis de ambiente
  # Configure no Terraform Cloud:
  # - ARM_CLIENT_ID
  # - ARM_CLIENT_SECRET
  # - ARM_SUBSCRIPTION_ID
  # - ARM_TENANT_ID
  # 
  # Ou use Managed Identity se disponível no Terraform Cloud
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}