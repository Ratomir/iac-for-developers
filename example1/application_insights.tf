###########################################
################# PAYMENT #################
###########################################
resource "azurerm_application_insights" "payment" {
  name                = "ai-payment-${var.project_name}-${var.env}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  workspace_id        = azurerm_log_analytics_workspace.service.id
  application_type    = "web"
}

###########################################
################# SCHEDULE ################
###########################################
resource "azurerm_application_insights" "schedule" {
  name                = "ai-schedule-${var.project_name}-${var.env}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  workspace_id        = azurerm_log_analytics_workspace.service.id
  application_type    = "web"
}
