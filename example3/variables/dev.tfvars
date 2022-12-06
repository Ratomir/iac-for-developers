subscription_id = "7d3606d4-570b-45db-8693-3b74f57fe1ee"
tenant_id       = "d7dedc1c-5e28-4c3b-a173-fe24b1923684"
project_name    = "sin22v3"
location        = "North Europe"
env             = "dev"

virtual_network = {
  address_space            = "11.12.0.0/16"
  address_prefixes_subnet1 = "11.12.0.0/17"
  address_prefixes_subnet2 = "11.12.128.0/17"
}

sql_database_retention_policy = {
  long_term = {
    weekly = "PT0S"
  }
  short_term = 7
}

aks_config = {
  oms_agent_enabled = false
  vm_size           = "Standard_B2s"
}

sql_server_credentials = {
  administrator_login          = "superadmin3232"
  administrator_login_password = "ads3232h@#)@#"
}

sinergija22services = [
  {
    name = "payment"
    useStorage = {
      blob  = true
      queue = true
    }
    sql_database = {
      sku_name = "Basic"
      sql_database_retention_policy = {
        long_term = {
          weekly = "PT0S"
        }
        short_term = 7
      }
    }
  },
  {
    name = "schedule"
    useStorage = {
      blob  = false
      queue = true
    }
    sql_database = null
  }
  # , {
  #   name = "simple"
  #   useStorage = {
  #     blob  = true
  #     queue = false
  #   }
  #   sql_database = null
  # }
]
