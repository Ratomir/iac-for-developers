output "applications_insights_id" {
  value = azurerm_application_insights.sinergija22service.app_id
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.sinergija22service.primary_blob_endpoint
}

output "primary_queue_endpoint" {
  value = azurerm_storage_account.sinergija22service.primary_queue_endpoint
}
