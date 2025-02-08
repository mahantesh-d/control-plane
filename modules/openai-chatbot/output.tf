output "webapp_url" {
    value = "https://${azurerm_app_service.app.default_site_hostname}"  
}

output "openai_endpoint" {
  value = azurerm_cognitive_account.openai.endpoint
}