###########################################
########### SINERGIJA 22 SERVICE ##########
###########################################
resource "azurerm_application_insights" "sinergija22service" {
  name                = "ai-${var.name}-${local.service_name}"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  workspace_id        = var.azurerm_log_analytics_workspace_id
  application_type    = "web"

  tags = local.basic_tags
}
