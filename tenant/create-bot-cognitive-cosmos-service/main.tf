module "bot-cog-cosmos" {
  source                  = "../../modules/bot-congnitive-cosmos"
  chat_bot_db_name        = var.chat_bot_db_name
  chatbot_container_name  = var.chatbot_container_name
  chatbot_service_name    = var.chatbot_service_name
  cognitive_services_name = var.cognitive_services_name
  cosmosdb_instance_name  = var.cosmosdb_instance_name
  location                = var.location
  microsoftappid          = var.microsoftappid
  resource_group_name     = var.resource_group_name

}



