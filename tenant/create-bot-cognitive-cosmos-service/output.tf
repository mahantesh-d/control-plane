output "bot_endpoint" {
  value = module.bot-cog-cosmos.bot_service_endpoint
}

output "cosmosdb_end" {
  value = module.bot-cog-cosmos.cosmosdb_endpoint
}

output "cognitive_key" {
  value = module.bot-cog-cosmos.cognitive_services_key
  sensitive = true
}