# Create a resource group
resource "azurerm_resource_group" "main" {
  name     = "rg-${var.project_name}-${var.env}"
  location = var.location

  tags = {
    Env     = var.env
    Project = var.project_name
  }
}
