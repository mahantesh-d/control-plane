data "azurerm_data_factory" "adf" {
  name                = var.azurerm_data_factory_name
  resource_group_name = var.resource_group_name
}


resource "azurerm_data_factory_pipeline" "pipeline" {
  name            = "my-sample-pipeline"
  data_factory_id = data.azurerm_data_factory.adf.id

  activities_json = <<JSON
  [
    {
      "name": "CopyData",
      "type": "Copy",
      "inputs": [{ "referenceName": "sourceDataset", "type": "DatasetReference" }],
      "outputs": [{ "referenceName": "destinationDataset", "type": "DatasetReference" }],
      "typeProperties": {
        "source": { "type": "BlobSource" },
        "sink": { "type": "BlobSink" }
      }
    }
  ]
  JSON
}