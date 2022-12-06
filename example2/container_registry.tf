resource "azurerm_container_registry" "acr" {
  name                = "cr${local.service_name_1}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = local.basic_tags
}
