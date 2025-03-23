terraform {
  backend "local" {
    path = "/opt/terraformstate/azure-data-factory.tfstate"
  }
}