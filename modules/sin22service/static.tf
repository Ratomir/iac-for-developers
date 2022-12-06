locals {
  kv_admin_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import",
  "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
  kv_admin_key_permissions = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get",
  "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"]
  kv_admin_secret_permissions     = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
  kv_app_read_secret_permissions  = ["Get", "List"]
  kv_read_certificate_permissions = ["Get", "List"]

  admin_user_list = ["ratomir_live.com#EXT#@ratomirlive.onmicrosoft.com"]

  service_name   = "${var.project_name}-${terraform.workspace}"
  service_name_1 = "${var.project_name}${terraform.workspace}"

  basic_tags = {
    Env     = terraform.workspace
    Project = var.project_name
    Service = var.name
  }
}

locals {
  is_dev  = terraform.workspace == "dev" ? 1 : 0
  is_prod = terraform.workspace == "prod" ? 1 : 0
}
