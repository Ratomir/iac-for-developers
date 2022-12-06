###########################################
################# PAYMENT #################
###########################################
resource "azurerm_key_vault" "payment" {
  name                        = "kv-payment-${var.project_name}-${var.env}"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  tags = {
    Env     = var.env
    Project = var.project_name
  }
}

resource "azurerm_key_vault_access_policy" "payment_admins" {
  count                   = length(data.azuread_users.admin_users.users)
  key_vault_id            = azurerm_key_vault.payment.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azuread_users.admin_users.users[count.index].object_id
  certificate_permissions = local.kv_admin_certificate_permissions
  key_permissions         = local.kv_admin_key_permissions
  secret_permissions      = local.kv_admin_secret_permissions
}

resource "azurerm_key_vault_access_policy" "payment_app" {
  key_vault_id       = azurerm_key_vault.payment.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = azuread_application.payment.object_id
  secret_permissions = local.kv_app_read_secret_permissions
}

resource "azurerm_key_vault_access_policy" "payment_k8s_csi" {
  key_vault_id       = azurerm_key_vault.payment.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = data.azurerm_user_assigned_identity.kvcsi.principal_id
  secret_permissions = local.kv_app_read_secret_permissions
}

###########################################
################# SCHEDULE ################
###########################################
resource "azurerm_key_vault" "schedule" {
  name                        = "kv-schedule-${var.project_name}-${var.env}"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  tags = {
    Env     = var.env
    Project = var.project_name
  }
}

resource "azurerm_key_vault_access_policy" "schedule_admins" {
  count                   = length(data.azuread_users.admin_users.users)
  key_vault_id            = azurerm_key_vault.schedule.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azuread_users.admin_users.users[count.index].object_id
  certificate_permissions = local.kv_admin_certificate_permissions
  key_permissions         = local.kv_admin_key_permissions
  secret_permissions      = local.kv_admin_secret_permissions
}

resource "azurerm_key_vault_access_policy" "schedule_app" {
  key_vault_id       = azurerm_key_vault.schedule.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = azuread_application.schedule.object_id
  secret_permissions = local.kv_app_read_secret_permissions
}

resource "azurerm_key_vault_access_policy" "schedule_k8s_csi" {
  key_vault_id       = azurerm_key_vault.schedule.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = data.azurerm_user_assigned_identity.kvcsi.principal_id
  secret_permissions = local.kv_app_read_secret_permissions
}
