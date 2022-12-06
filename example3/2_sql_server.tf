resource "azurerm_mssql_server" "main" {
  name                         = "sql-${local.service_name}"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = var.sql_server_credentials.administrator_login
  administrator_login_password = var.sql_server_credentials.administrator_login_password
  minimum_tls_version          = "1.2"

  #   azuread_administrator {
  #     login_username = "sqlserver-admin-${terraform.workspace}"
  #     object_id      = data.azuread_group.sqlserver_admin.object_id
  #   }

  tags = local.basic_tags
}
