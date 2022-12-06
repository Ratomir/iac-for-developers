resource "azurerm_monitor_metric_alert" "database_storage" {
  count                = local.add_storage_alarm
  name                 = "Maximum storage - ${var.properties.name} - ${terraform.workspace}"
  resource_group_name  = var.resource_group.name
  scopes               = [var.sql_server.id]
  target_resource_type = "Microsoft.Sql/servers/databases"
  description          = "Whenever the maximum data space used percent is greater than 85%."

  severity    = 0
  enabled     = true
  window_size = "PT15M"
  frequency   = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "storage_percent"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 85
  }

  auto_mitigate = true

  action {
    action_group_id    = var.database_storage_action_group_id
    webhook_properties = {}
  }

  tags = merge({ "db" : var.properties.name }, local.basic_tags)
}
