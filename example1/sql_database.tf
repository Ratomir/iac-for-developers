###########################################
################# PAYMENT #################
###########################################
resource "azurerm_mssql_database" "sql_database_payment" {
  name      = "sqldb-payment-${var.project_name}-${var.env}"
  server_id = azurerm_mssql_server.main.id
  sku_name  = "Basic"

  long_term_retention_policy {
    weekly_retention = "PT0S"
    week_of_year     = 1
  }

  short_term_retention_policy {
    retention_days = 7
  }

  storage_account_type = "Local"

  tags = {
    Env     = var.env
    Project = var.project_name
  }

  lifecycle {
    ignore_changes = [
      long_term_retention_policy
    ]
  }
}

###########################################
################# SCHEDULE ################
###########################################
resource "azurerm_mssql_database" "sql_database_schedule" {
  name      = "sqldb-schedule-${var.project_name}-${var.env}"
  server_id = azurerm_mssql_server.main.id
  sku_name  = "Basic"

  long_term_retention_policy {
    weekly_retention = "PT0S"
    week_of_year     = 1
  }

  short_term_retention_policy {
    retention_days = 7
  }

  storage_account_type = "Local"

  tags = {
    Env     = var.env
    Project = var.project_name
  }

  lifecycle {
    ignore_changes = [
      long_term_retention_policy
    ]
  }
}

