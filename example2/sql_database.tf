###########################################
################# PAYMENT #################
###########################################
module "payment_database" {
  source         = "../modules/sql_database"
  name           = "payment"
  project_name   = var.project_name
  resource_group = azurerm_resource_group.main
  sql_server     = azurerm_mssql_server.main
  properties     = var.sql_database_retention_policy
  depends_on = [
    azurerm_mssql_server.main
  ]
}

###########################################
################# SCHEDULE ################
###########################################
module "schedule_database" {
  source         = "../modules/sql_database"
  name           = "schedule"
  project_name   = var.project_name
  resource_group = azurerm_resource_group.main
  sql_server     = azurerm_mssql_server.main
  properties     = var.sql_database_retention_policy
  depends_on = [
    azurerm_mssql_server.main
  ]
}

