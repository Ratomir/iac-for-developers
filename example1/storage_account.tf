###########################################
################# PAYEMENT ################
###########################################
resource "azurerm_storage_account" "payment" {
  name                     = "stpayment${var.project_name}${var.env}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Env     = var.env
    Project = var.project_name
  }
}

resource "azurerm_storage_container" "payment_input" {
  name                  = "input"
  storage_account_name  = azurerm_storage_account.payment.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "payment_output" {
  name                  = "output"
  storage_account_name  = azurerm_storage_account.payment.name
  container_access_type = "private"
}

resource "azurerm_storage_queue" "payment" {
  name                 = "payment-in"
  storage_account_name = azurerm_storage_account.payment.name
}

resource "azurerm_role_assignment" "payment_role_blob" {
  scope                = azurerm_storage_account.payment.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.payment.object_id
}

resource "azurerm_role_assignment" "payment_role_queue" {
  scope                = azurerm_storage_account.payment.id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = azuread_service_principal.payment.object_id
}

###########################################
################# SCHEDULE ################
###########################################
resource "azurerm_storage_account" "schedule" {
  name                     = "stschedule${var.project_name}${var.env}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Env     = var.env
    Project = var.project_name
  }
}

resource "azurerm_storage_container" "schedule_input" {
  name                  = "input"
  storage_account_name  = azurerm_storage_account.schedule.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "schedule_output" {
  name                  = "output"
  storage_account_name  = azurerm_storage_account.schedule.name
  container_access_type = "private"
}

resource "azurerm_storage_queue" "schedule" {
  name                 = "schedule-in"
  storage_account_name = azurerm_storage_account.schedule.name
}

resource "azurerm_role_assignment" "schedule_role_blob" {
  scope                = azurerm_storage_account.schedule.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.schedule.object_id
}

resource "azurerm_role_assignment" "schedule_role_queue" {
  scope                = azurerm_storage_account.schedule.id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = azuread_service_principal.schedule.id
}
