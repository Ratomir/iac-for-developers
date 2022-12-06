###########################################
########### SINERGIJA 22 SERVICE ##########
###########################################
resource "azurerm_storage_account" "sinergija22service" {
  name                     = "st${var.name}${local.service_name_1}"
  location                 = var.resource_group.location
  resource_group_name      = var.resource_group.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.basic_tags
}

resource "azurerm_storage_container" "sinergija22service_input" {
  name                  = "input"
  storage_account_name  = azurerm_storage_account.sinergija22service.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "sinergija22service_output" {
  name                  = "output"
  storage_account_name  = azurerm_storage_account.sinergija22service.name
  container_access_type = "private"
}

resource "azurerm_storage_queue" "sinergija22service" {
  name                 = "${var.name}-in"
  storage_account_name = azurerm_storage_account.sinergija22service.name
}

resource "azurerm_role_assignment" "sinergija22service_role_blob" {
  scope                = azurerm_storage_account.sinergija22service.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.sinergija22service.object_id
}

resource "azurerm_role_assignment" "sinergija22service_role_queue" {
  scope                = azurerm_storage_account.sinergija22service.id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = azuread_service_principal.sinergija22service.object_id
}
