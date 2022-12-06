variable "properties" {
}

variable "name" {
  type = string
}

variable "resource_group" {
}

variable "project_name" {
  type    = string
  default = "sin22v2"
}

variable "sql_server" {
}

variable "database_storage_action_group_id" {
  type    = string
  default = null
}

data "azurerm_client_config" "current" {}
