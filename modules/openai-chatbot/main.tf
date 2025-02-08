data "azurerm_client_config" "config" {}

#create resource group
resource "azurerm_resource_group" "rg" {
    location = var.location
    name = var.resource_group_name  
}

#Creating the app service plan
resource "azurerm_app_service_plan" "planname" {
    name = var.app_service_plan_name
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    kind = "FunctionApp"
    reserved = true
    sku {
      tier = "Free"
      size = "F1"
    }
  
}

#Create the app service for hosting chatbot
resource "azurerm_app_service" "app" {
    name = var.web_app_name
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_app_service_plan.planname.name
    app_service_plan_id = azurerm_app_service_plan.planname.id

    site_config {
      linux_fx_version = "PYTHON|3.9"
    }  
}

#Create Azure open AI Service for GPT-based AI
resource "azurerm_cognitive_account" "openai" {
    name = var.open_ai_name
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    kind = "OpenAI"
    sku_name = "S0"  
}

#Create Azure Bot Service
resource "azurerm_bot_service_azure_bot" "name" {
  name = var.bot_name
  resource_group_name = azurerm_resource_group.rg.name
  location = "global"
  microsoft_app_id = data.azurerm_client_config.config.client_id
  sku = "F0"

  endpoint = "https://${azurerm_app_service.app.default_site_hostname}/api/messages"

}


