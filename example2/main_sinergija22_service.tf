###########################################
################# PAYMENT #################
###########################################
module "payment_service" {
  source                             = "../modules/sin22service"
  aks_cluster                        = azurerm_kubernetes_cluster.aks
  azurerm_log_analytics_workspace_id = azurerm_log_analytics_workspace.service.id
  name                               = "payment"
  project_name                       = var.project_name
  resource_group                     = azurerm_resource_group.main
}

###########################################
################# SCHEDULE ################
###########################################
module "schedule_service" {
  source                             = "../modules/sin22service"
  aks_cluster                        = azurerm_kubernetes_cluster.aks
  azurerm_log_analytics_workspace_id = azurerm_log_analytics_workspace.service.id
  name                               = "schedule"
  project_name                       = var.project_name
  resource_group                     = azurerm_resource_group.main
}
