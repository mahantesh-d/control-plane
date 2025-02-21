output "bot_service_endpoint" {
  value = azurerm_bot_service_azure_bot.chatbot.endpoint
}

output "cognitive_services_key" {
  value     = azurerm_cognitive_account.cognitive_services.primary_access_key
  sensitive = true
}

output "cosmosdb_endpoint" {
  value = azurerm_cosmosdb_account.cosmosdb.endpoint
}
