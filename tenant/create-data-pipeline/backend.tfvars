terraform {
  backend "local" {
    path = "/opt/terraformstate/azure-data-pipeline.tfstate"
  }
}