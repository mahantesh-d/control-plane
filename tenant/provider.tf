terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.18.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "975da75d-d34d-42b9-a373-74fd3dc47c0e"
  tenant_id       = "11750f66-775d-4dcf-99c7-3dd45ae5bb96"
  features {
    
  }

}