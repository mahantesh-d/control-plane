module "adf" {
  source              = "../../modules/azure-data-factory"
  data_factory_name   = var.data_factory_name
  resource_group_name = var.resource_group_name
  location            = var.location
  self_hosted_runtime = var.self_hosted_runtime
}