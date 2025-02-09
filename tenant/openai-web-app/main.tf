module "web_app_ai_bot" {
  source                       = "../../modules/openai-chatbot"
  app_service_plan_name        = var.app_service_plan_name
  bot_name                     = var.bot_name
  location                     = var.location
  open_ai_name                 = var.open_ai_name
  resource_group_name          = var.resource_group_name
  subnet_name                  = var.subnet_name
  vnet_integration_subnet_name = var.vnet_integration_subnet_name
  vnet_name                    = var.vnet_name
  vnet_resource_group          = var.vnet_resource_group
  web_app_name                 = var.web_app_name
}