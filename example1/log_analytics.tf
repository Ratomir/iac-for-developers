resource "azurerm_log_analytics_workspace" "aks" {
  name                = "la-aks-${var.project_name}-${var.env}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_log_analytics_workspace" "service" {
  name                = "ls-service-${var.project_name}-${var.env}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
