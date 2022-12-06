###########################################
################# PAYMENT #################
###########################################
module "payment_service" {
  source                             = "../modules/sin22servicev3"
  aks_cluster                        = azurerm_kubernetes_cluster.aks
  azurerm_log_analytics_workspace_id = azurerm_log_analytics_workspace.service.id
  name                               = "payment"
  project_name                       = var.project_name
  resource_group                     = azurerm_resource_group.main
  aks_csi = {
    enabled     = true
    identity_id = data.azurerm_user_assigned_identity.kvcsi.principal_id
  }
  sql_server_credentials        = var.sql_server_credentials
  sql_database_retention_policy = var.sql_database_retention_policy
  kv_admin_user_list            = local.admin_user_list
  sql_server                    = azurerm_mssql_server.main
}

###########################################
################# SCHEDULE #################
###########################################
module "schedule_service" {
  source                             = "../modules/sin22servicev3"
  aks_cluster                        = azurerm_kubernetes_cluster.aks
  azurerm_log_analytics_workspace_id = azurerm_log_analytics_workspace.service.id
  name                               = "schedule"
  project_name                       = var.project_name
  resource_group                     = azurerm_resource_group.main
  aks_csi = {
    enabled     = true
    identity_id = data.azurerm_user_assigned_identity.kvcsi.principal_id
  }
  sql_server_credentials        = var.sql_server_credentials
  sql_database_retention_policy = var.sql_database_retention_policy
  kv_admin_user_list            = local.admin_user_list
  sql_server                    = azurerm_mssql_server.main
}
