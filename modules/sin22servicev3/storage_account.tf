###########################################
########### SINERGIJA 22 SERVICE ##########
###########################################

locals {
  include_blob  = var.service_config_model.useStorage != null ? (var.service_config_model.useStorage.blob ? 1 : 0) : 0
  include_queue = var.service_config_model.useStorage != null ? (var.service_config_model.useStorage.queue ? 1 : 0) : 0
}

resource "azurerm_storage_account" "sinergija22service" {
  name                     = "st${var.service_config_model.name}${local.service_name_1}"
  location                 = var.resource_group.location
  resource_group_name      = var.resource_group.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.basic_tags
}

resource "azurerm_storage_container" "sinergija22service_input" {
  count                 = local.include_blob
  name                  = "input"
  storage_account_name  = azurerm_storage_account.sinergija22service.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "sinergija22service_output" {
  count                 = local.include_blob
  name                  = "output"
  storage_account_name  = azurerm_storage_account.sinergija22service.name
  container_access_type = "private"
}

resource "azurerm_storage_queue" "sinergija22service" {
  count                = local.include_queue
  name                 = "${var.service_config_model.name}-in"
  storage_account_name = azurerm_storage_account.sinergija22service.name
}

resource "azurerm_role_assignment" "sinergija22service_role_blob" {
  count = local.include_blob

  scope                = azurerm_storage_account.sinergija22service.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.sinergija22service.object_id
}

resource "azurerm_role_assignment" "sinergija22service_role_queue" {
  count = local.include_queue

  scope                = azurerm_storage_account.sinergija22service.id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = azuread_service_principal.sinergija22service.object_id
}
