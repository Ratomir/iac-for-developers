resource "azurerm_log_analytics_workspace" "aks" {
  name                = "la-aks-${local.service_name}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = local.basic_tags
}

resource "azurerm_log_analytics_workspace" "service" {
  name                = "ls-service-${local.service_name}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = local.basic_tags
}
