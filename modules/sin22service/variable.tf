variable "name" {
  type = string
}

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

data "azurerm_client_config" "current" {}
