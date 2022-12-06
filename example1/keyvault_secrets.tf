###########################################
################# PAYMENT #################
###########################################
resource "azurerm_key_vault_secret" "payment_application_insights" {
  name         = "application-insights-id"
  value        = azurerm_application_insights.payment.app_id
  key_vault_id = azurerm_key_vault.payment.id

  tags = {
    Env     = var.env
    Project = var.project_name
    Service = "payment"
  }

  depends_on = [
    azurerm_key_vault_access_policy.payment_admins
  ]
}

resource "azurerm_key_vault_secret" "payment_connection_string" {
  name         = "ConnectionString--PaymentDb"
  value        = "Server=tcp:sql-${var.project_name}-${var.env}.database.windows.net,1433;Initial Catalog=sqldb-payment-${var.project_name}-${var.env};Persist Security Info=False;User ID=${var.sql_server_credentials.administrator_login};Password=${var.sql_server_credentials.administrator_login_password};MultipleActiveResultSets=True;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  key_vault_id = azurerm_key_vault.payment.id

  tags = {
    Env     = var.env
    Project = var.project_name
    Service = "payment"
  }

  depends_on = [
    azurerm_key_vault_access_policy.payment_admins
  ]
}

resource "azurerm_key_vault_secret" "payment_storage_blob" {
  name         = "ConnectionString--StorageAccount--Blob"
  value        = azurerm_storage_account.payment.primary_blob_endpoint
  key_vault_id = azurerm_key_vault.payment.id

  tags = {
    Env     = var.env
    Project = var.project_name
    Service = "payment"
  }

  depends_on = [
    azurerm_key_vault_access_policy.payment_admins
  ]
}

resource "azurerm_key_vault_secret" "payment_storage_queue" {
  name         = "ConnectionString--StorageAccount--Queue"
  value        = azurerm_storage_account.payment.primary_queue_endpoint
  key_vault_id = azurerm_key_vault.payment.id

  tags = {
    Env     = var.env
    Project = var.project_name
    Service = "payment"
  }

  depends_on = [
    azurerm_key_vault_access_policy.payment_admins
  ]
}

###########################################
################# SCHEDULE ################
###########################################
resource "azurerm_key_vault_secret" "schedule_application_insights" {
  name         = "application-insights-id"
  value        = azurerm_application_insights.schedule.app_id
  key_vault_id = azurerm_key_vault.schedule.id

  tags = {
    Env     = var.env
    Project = var.project_name
    Service = "schedule"
  }

  depends_on = [
    azurerm_key_vault_access_policy.schedule_admins
  ]
}

resource "azurerm_key_vault_secret" "schedule_connection_string" {
  name         = "ConnectionString--ScheduleDb"
  value        = "Server=tcp:sql-${var.project_name}-${var.env}.database.windows.net,1433;Initial Catalog=sqldb-schedule-${var.project_name}-${var.env};Persist Security Info=False;User ID=${var.sql_server_credentials.administrator_login};Password=${var.sql_server_credentials.administrator_login_password};MultipleActiveResultSets=True;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  key_vault_id = azurerm_key_vault.schedule.id

  tags = {
    Env     = var.env
    Project = var.project_name
    Service = "schedule"
  }

  depends_on = [
    azurerm_key_vault_access_policy.schedule_admins
  ]
}

resource "azurerm_key_vault_secret" "schedule_storage_blob" {
  name         = "ConnectionString--StorageAccount--Blob"
  value        = azurerm_storage_account.schedule.primary_blob_endpoint
  key_vault_id = azurerm_key_vault.schedule.id

  tags = {
    Env     = var.env
    Project = var.project_name
    Service = "schedule"
  }

  depends_on = [
    azurerm_key_vault_access_policy.schedule_admins
  ]
}

resource "azurerm_key_vault_secret" "schedule_storage_queue" {
  name         = "ConnectionString--StorageAccount--Queue"
  value        = azurerm_storage_account.schedule.primary_queue_endpoint
  key_vault_id = azurerm_key_vault.schedule.id

  tags = {
    Env     = var.env
    Project = var.project_name
    Service = "schedule"
  }

  depends_on = [
    azurerm_key_vault_access_policy.schedule_admins
  ]
}
