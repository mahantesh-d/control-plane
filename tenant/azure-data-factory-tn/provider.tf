terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.17.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "60fee15d-dea2-41d3-b8a2-e04507a13ced"
  tenant_id       = "11750f66-775d-4dcf-99c7-3dd45ae5bb96"
  features {

  }

}