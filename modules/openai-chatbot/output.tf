output "webapp_url" {
  value = "https://${azurerm_linux_web_app.app.default_hostname}"
}

output "openai_endpoint" {
  value = azurerm_cognitive_account.restaurantAI.endpoint
}