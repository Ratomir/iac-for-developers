variable "name" {
  type = string
}

variable "resource_group" {
}

variable "project_name" {
  type    = string
  default = "sin22v2"
}

variable "aks_csi" {
  type = object({
    identity_id = string
  })
  default = null
}

variable "kv_admin_user_list" {
  type = list(string)
}

variable "secrets" {
  type = list(object({
    key   = string
    value = string
  }))
}

data "azurerm_client_config" "current" {}

data "azuread_users" "admin_users" {
  user_principal_names = var.kv_admin_user_list
}
