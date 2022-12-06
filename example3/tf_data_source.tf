data "azurerm_client_config" "current" {}

data "azuread_users" "admin_users" {
  user_principal_names = local.admin_user_list
}
