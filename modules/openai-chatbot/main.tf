data "azurerm_client_config" "config" {}


#Get the subnet
# data "azurerm_subnet" "vnet_integration" {
#   name                 = var.vnet_integration_subnet_name
#   resource_group_name  = var.vnet_resource_group
#   virtual_network_name = var.vnet_name
# }

# data "azurerm_subnet" "private_endpoint" {
#   name                 = var.subnet_name
#   resource_group_name  = var.vnet_resource_group
#   virtual_network_name = var.vnet_name
# }

#Create the server farm
# resource "null_resource" "this" {
#   provisioner "local-exec" {
#     command = <<EOF
#     echo "az command"
#     if [[ $(az network vnet subnet show --name ${var.vnet_integration_subnet_name} --vnet-name ${var.vnet_name} --resource-group ${var.vnet_resource_group} --query 'length(delegations[?serviceName == `Microsoft.Web/serverFarms`])') == 0 ]]; then
#     az network vnet subnet update --name ${var.vnet_integration_subnet_name} --vnet-name ${var.vnet_name} --resource-group ${var.vnet_resource_group} --delegations Microsoft.Web/serverFarms
#     echo "Subnet was successfully delegated"
#     else
#     echo "Subnet is already delegated"
#     fi
#     EOF
#   }
# }

#create resource group
resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = var.resource_group_name
}

#Creating the app service plan
resource "azurerm_service_plan" "planname" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "F1"

}


# resource "azurerm_app_service_virtual_network_swift_connection" "this" {
#   depends_on     = [null_resource.this]
#   app_service_id = azurerm_linux_web_app.app.id
#   subnet_id      = data.azurerm_subnet.vnet_integration.id
# }

# resource "azurerm_private_endpoint" "pe" {
#   name                = "restaurant-ai-chatbot-pe"
#   location            = var.location
#   resource_group_name = azurerm_resource_group.rg.name
#   subnet_id           = data.azurerm_subnet.private_endpoint.id
#   private_service_connection {
#     name                           = "restaurant-ai-chatbot-pe-sc"
#     private_connection_resource_id = azurerm_linux_web_app.app.id
#     is_manual_connection           = false
#     subresource_names              = ["sites"]
#   }

# }

#Create Azure open AI Service for GPT-based AI
resource "azurerm_cognitive_account" "restaurantAI" {
  name                = var.open_ai_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "OpenAI"
  sku_name            = "S0"
}

#Create Azure Bot Service
resource "azurerm_bot_service_azure_bot" "name" {
  name                = var.bot_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = "global"
  # microsoft_app_id    = data.azurerm_client_config.config.client_id
  microsoft_app_id = var.microsoftappid
  sku              = "F0"

  endpoint = "https://${azurerm_linux_web_app.app.default_hostname}/api/messages"

}

#Create the app service for hosting chatbot
resource "azurerm_linux_web_app" "app" {
  name                = var.web_app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.planname.id
  public_network_access_enabled = true

  app_settings = {
    AZURE_OPENAI_ENDPOINT=azurerm_cognitive_account.restaurantAI.endpoint
    AZURE_OPENAI_API_KEY=azurerm_cognitive_account.restaurantAI.primary_access_key
    WEBSITES_PORT="8000"
    STARTUP_COMMAND = "pip install -r requirements.txt && gunicorn -b 0.0.0.0:8000 app:app"
  }  
  site_config {
    application_stack {
      python_version = "3.11"
    }
    always_on = false
    # ip_restriction {
    #   ip_address = "0.0.0.0/0"
    #   action     = "Deny"
    #   name       = "DenyAllPublic"
    #   priority   = 1
    #   headers    = []
    # }
  }

}


