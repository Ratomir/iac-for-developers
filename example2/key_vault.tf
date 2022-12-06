module "payment_keyvault" {
  source = "../modules/keyvault"
  aks_csi = {
    enabled     = true
    identity_id = data.azurerm_user_assigned_identity.kvcsi.principal_id
  }
  kv_admin_user_list = local.admin_user_list
  project_name       = var.project_name
  resource_group     = azurerm_resource_group.main
  name               = "payment"
  secrets = [{
    key   = "application-insights-id"
    value = module.payment_service.applications_insights_id
    },
    {
      key   = "ConnectionString--PaymentDb"
      value = "Server=tcp:sql-${local.service_name}.database.windows.net,1433;Initial Catalog=sqldb-payment-${local.service_name};Persist Security Info=False;User ID=${var.sql_server_credentials.administrator_login};Password=${var.sql_server_credentials.administrator_login_password};MultipleActiveResultSets=True;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
    },
    {
      key   = "ConnectionString--StorageAccount--Blob"
      value = module.payment_service.primary_blob_endpoint
    },
    {
      key   = "ConnectionString--StorageAccount--Queue"
      value = module.payment_service.primary_queue_endpoint
    }
  ]
  depends_on = [

  ]
}

module "schedule_keyvault" {
  source = "../modules/keyvault"
  aks_csi = {
    enabled     = true
    identity_id = data.azurerm_user_assigned_identity.kvcsi.principal_id
  }
  kv_admin_user_list = local.admin_user_list
  project_name       = var.project_name
  resource_group     = azurerm_resource_group.main
  name               = "schedule"
  secrets = [{
    key   = "application-insights-id"
    value = module.schedule_service.applications_insights_id
    },
    {
      key   = "ConnectionString--ScheduleDb"
      value = "Server=tcp:sql-${local.service_name}.database.windows.net,1433;Initial Catalog=sqldb-schedule-${local.service_name};Persist Security Info=False;User ID=${var.sql_server_credentials.administrator_login};Password=${var.sql_server_credentials.administrator_login_password};MultipleActiveResultSets=True;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
    },
    {
      key   = "ConnectionString--StorageAccount--Blob"
      value = module.schedule_service.primary_blob_endpoint
    },
    {
      key   = "ConnectionString--StorageAccount--Queue"
      value = module.schedule_service.primary_queue_endpoint
    }
  ]
  depends_on = [

  ]
}
