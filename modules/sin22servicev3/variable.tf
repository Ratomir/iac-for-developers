variable "resource_group" {
}

variable "project_name" {
  type    = string
  default = "sin22v2"
}

variable "azurerm_log_analytics_workspace_id" {
  type = string
}

variable "aks_cluster" {
}

variable "sql_server" {
  type    = any
  default = null
}

variable "database_storage_action_group_id" {
  type    = string
  default = null
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

variable "sql_server_credentials" {
  type = object({
    administrator_login          = string
    administrator_login_password = string
  })
}

variable "service_config_model" {
  type = object({
    name = string
    useStorage = object({
      blob  = bool
      queue = bool
    })
    sql_database = object({
      sku_name = string
      sql_database_retention_policy = object({
        long_term = object({
          weekly = string
        })
        short_term = number
      })
    })
  })
}

data "azurerm_client_config" "current" {}
