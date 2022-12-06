###########################################
########### SINERGIJA 22 SERVICE ##########
###########################################
resource "azurerm_key_vault" "sinergija22service" {
  name                        = "kv-${var.name}-${local.service_name}"
  location                    = var.resource_group.location
  resource_group_name         = var.resource_group.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  tags = local.basic_tags
}

resource "azurerm_key_vault_access_policy" "aks_csi" {
  count        = var.aks_csi != null ? 1 : 0
  key_vault_id = azurerm_key_vault.sinergija22service.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.aks_csi.identity_id

  secret_permissions = local.kv_app_read_secret_permissions
}

resource "azurerm_key_vault_access_policy" "admins" {
  count                   = length(var.kv_admin_user_list)
  key_vault_id            = azurerm_key_vault.sinergija22service.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azuread_users.admin_users.users[count.index].object_id
  certificate_permissions = local.kv_admin_certificate_permissions
  key_permissions         = local.kv_admin_key_permissions
  secret_permissions      = local.kv_admin_secret_permissions
}

resource "azurerm_key_vault_secret" "secrets" {
  depends_on = [
    azurerm_key_vault_access_policy.admins
  ]
  count        = length(var.secrets)
  name         = var.secrets[count.index].key
  value        = var.secrets[count.index].value
  key_vault_id = azurerm_key_vault.sinergija22service.id

  tags = local.basic_tags
}

# resource "azurerm_key_vault_access_policy" "key_vault_shared_azure_devops_policy" {
#   key_vault_id            = azurerm_key_vault.key_vault.id
#   tenant_id               = data.azurerm_client_config.current.tenant_id
#   object_id               = data.azuread_service_principal.azure_devops.object_id
#   certificate_permissions = local.kv_admin_certificate_permissions
#   key_permissions         = local.kv_admin_key_permissions
#   secret_permissions      = local.kv_admin_secret_permissions
# }
