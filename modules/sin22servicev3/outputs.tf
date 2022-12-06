output "application_id" {
  value = "${var.service_config_model.name} => ${azuread_service_principal.sinergija22service.application_id}"
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.sinergija22service.primary_blob_endpoint
}

output "primary_queue_endpoint" {
  value = azurerm_storage_account.sinergija22service.primary_queue_endpoint
}
