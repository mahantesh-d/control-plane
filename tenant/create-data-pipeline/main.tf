module "data-pipeline" {
  source                    = "../../modules/azure-data-pipeline"
  resource_group_name       = var.resource_group_name
  azurerm_data_factory_name = var.azurerm_data_factory_name
}