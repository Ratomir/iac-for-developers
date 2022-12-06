locals {
  service_name = "${var.project_name}-${terraform.workspace}"

  add_storage_alarm = var.database_storage_action_group_id != null ? 1 : 0

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
