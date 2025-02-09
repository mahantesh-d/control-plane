module "create_vnet" {
  source              = "../../modules/create-vnet"
  location            = var.location
  nsg_name            = var.nsg_name
  resource_group_name = var.resource_group_name
  vnet_name           = var.vnet_name
}