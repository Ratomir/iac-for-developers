locals {
  secrets_app_id = [
    {
      key   = "application-insights-id"
      value = azurerm_application_insights.sinergija22service.app_id
    }
  ]
  secrets_db = local.include_database == 1 ? concat(local.secrets_app_id, [
    {
      key   = "ConnectionStrings--${title(var.service_config_model.name)}Db"
      value = "Server=tcp:sql-${local.service_name}.database.windows.net,1433;Initial Catalog=sqldb-${var.service_config_model.name}-${local.service_name};Persist Security Info=False;User ID=${var.sql_server_credentials.administrator_login};Password=${var.sql_server_credentials.administrator_login_password};MultipleActiveResultSets=True;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
    }
  ]) : local.secrets_app_id
  secrets_blob = local.include_blob == 1 ? concat(local.secrets_db, [
    {
      key   = "ConnectionStrings--StorageAccount--Blob"
      value = azurerm_storage_account.sinergija22service.primary_blob_endpoint
    }
  ]) : local.secrets_db
  secrets_queue = local.include_queue == 1 ? concat(local.secrets_blob, [
    {
      key   = "ConnectionStrings--StorageAccount--Queue"
      value = azurerm_storage_account.sinergija22service.primary_queue_endpoint
    }
  ]) : local.secrets_blob
}

locals {
  final_secrets = local.secrets_queue
}

module "keyvault" {
  source             = "../keyvault"
  aks_csi            = var.aks_csi
  kv_admin_user_list = var.kv_admin_user_list
  project_name       = var.project_name
  resource_group     = var.resource_group
  name               = var.service_config_model.name
  secrets            = local.final_secrets
  depends_on = [

  ]
}
