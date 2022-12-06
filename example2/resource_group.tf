# Create a resource group
resource "azurerm_resource_group" "main" {
  name     = "rg-${local.service_name}"
  location = var.location

  tags = local.basic_tags
}
