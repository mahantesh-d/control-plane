output "adf_name" {
  value = azurerm_data_factory.adf.name
}

output "adf_identity" {
  value = azurerm_data_factory.adf.identity[0].principal_id
}

output "adf_ir_name" {
  value = azurerm_data_factory_integration_runtime_azure.ir.name
}