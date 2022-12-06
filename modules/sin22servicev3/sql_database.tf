###########################################
################# DATABASE ################
###########################################
locals {
  include_database = var.service_config_model.sql_database != null ? 1 : 0
}

module "database" {
  count          = local.include_database
  source         = "../sql_database"
  name           = var.service_config_model.name
  project_name   = var.project_name
  resource_group = var.resource_group
  sql_server     = var.sql_server
  properties     = var.service_config_model.sql_database.sql_database_retention_policy
}
