
# Creating the reosurce grouo
resource "azurerm_resource_group" "chatbot_rg" {
  name     = var.resource_group_name
  location = var.location
}

#Creating the cognitive services
resource "azurerm_cognitive_account" "cognitive_services" {
  name                = var.cognitive_services_name
  location            = azurerm_resource_group.chatbot_rg.location
  resource_group_name = azurerm_resource_group.chatbot_rg.name
  kind                = "CognitiveServices"
  sku_name            = "S0"
}

resource "azurerm_bot_service_azure_bot" "chatbot" {
  name                = var.chatbot_service_name
  location            = "Global"
  resource_group_name = azurerm_resource_group.chatbot_rg.name
  microsoft_app_id    = var.microsoftappid
  sku                 = "S1"
}

#Creating the cosmosdb instances
resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = var.cosmosdb_instance_name
  location            = azurerm_resource_group.chatbot_rg.location
  resource_group_name = azurerm_resource_group.chatbot_rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  geo_location {
    failover_priority = 0
    location          = "North Europe"
  }
  consistency_policy {
    consistency_level = "Session"
  }
}

resource "azurerm_cosmosdb_sql_database" "chatbot_db" {
  name                = var.chat_bot_db_name
  resource_group_name = azurerm_resource_group.chatbot_rg.name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
}

resource "azurerm_cosmosdb_sql_container" "chatbot_container" {
  name                = var.chatbot_container_name
  resource_group_name = azurerm_resource_group.chatbot_rg.name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
  database_name       = azurerm_cosmosdb_sql_database.chatbot_db.name
  partition_key_paths = ["/id"]
  throughput          = 400
}