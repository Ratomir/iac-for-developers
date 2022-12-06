
module "sinergija22service" {
  count       = length(var.sinergija22services)
  source      = "../modules/sin22servicev3"
  aks_cluster = azurerm_kubernetes_cluster.aks
  aks_csi = {
    identity_id = data.azurerm_user_assigned_identity.kvcsi.principal_id
  }
  azurerm_log_analytics_workspace_id = azurerm_log_analytics_workspace.service.id
  project_name                       = var.project_name
  resource_group                     = azurerm_resource_group.main
  service_config_model               = var.sinergija22services[count.index]
  sql_server                         = var.sinergija22services[count.index].sql_database != null ? azurerm_mssql_server.main : null
  sql_server_credentials             = var.sql_server_credentials
  kv_admin_user_list                 = local.admin_user_list
}
