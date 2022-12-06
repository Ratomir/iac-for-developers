variable "subscription_id" {
  type    = string
  default = "7d3606d4-570b-45db-8693-3b74f57fe1ee"
}

variable "tenant_id" {
  type    = string
  default = "d7dedc1c-5e28-4c3b-a173-fe24b1923684"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "virtual_network" {
  type = object({
    address_space            = string
    address_prefixes_subnet1 = string
    address_prefixes_subnet2 = string
  })
}

variable "project_name" {
  type    = string
  default = "sin22v1"
}

variable "location" {
  type    = string
  default = "Norway Europe"
}

variable "sql_database_retention_policy" {
  type = object({
    long_term = object({
      weekly = string
    })
    short_term = number
  })
}

variable "aks_config" {
  type = object({
    oms_agent_enabled = bool
    vm_size           = string
  })
}

variable "sql_server_credentials" {
  type = object({
    administrator_login          = string
    administrator_login_password = string
  })
}
