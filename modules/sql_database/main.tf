###########################################
########### SINERGIJA 22 SERVICE ##########
###########################################
resource "azurerm_mssql_database" "sinergija22service" {
  name      = "sqldb-${var.name}-${local.service_name}"
  server_id = var.sql_server.id
  sku_name  = "Basic"

  long_term_retention_policy {
    weekly_retention = "PT0S"
    week_of_year     = 1
  }

  short_term_retention_policy {
    retention_days = 7
  }

  storage_account_type = "Local"

  tags = local.basic_tags

  lifecycle {
    ignore_changes = [
      long_term_retention_policy
    ]
  }
}
