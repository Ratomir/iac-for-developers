subscription_id = "7d3606d4-570b-45db-8693-3b74f57fe1ee"
tenant_id       = "d7dedc1c-5e28-4c3b-a173-fe24b1923684"
project_name    = "sin22v1"
location        = "North Europe"
env             = "dev"

virtual_network = {
  address_space            = "11.0.0.0/16"
  address_prefixes_subnet1 = "11.0.0.0/17"
  address_prefixes_subnet2 = "11.0.128.0/17"
}

sql_database_retention_policy = {
  long_term = {
    weekly = "PT0S"
  }
  short_term = 7
}

aks_config = {
  oms_agent_enabled = false
  vm_size           = "Standard_B4ms"
}

sql_server_credentials = {
  administrator_login          = "superadmin3232"
  administrator_login_password = "ads3232h@#)@#"
}
