resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${local.service_name}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "aks${local.service_name_1}"

  aci_connector_linux {
    subnet_name = azurerm_subnet.aks_2.name
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.aks.id
  }

  azure_policy_enabled = true

  node_resource_group = "rg-aks-node-${local.service_name}"

  oidc_issuer_enabled = true

  network_profile {
    network_plugin = "azure"

    load_balancer_sku = "standard"

    # load_balancer_profile {
    # idle_timeout_in_minutes = 30
    # outbound_ip_address_ids = [azurerm_public_ip.aks_public.id]
    # }
  }

  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "2m"
  }

  default_node_pool {
    name           = "agentpool"
    node_count     = 2
    vm_size        = var.aks_config.vm_size
    type           = "VirtualMachineScaleSets"
    vnet_subnet_id = azurerm_subnet.aks_1.id

    enable_auto_scaling = true
    min_count           = 1
    max_count           = 5

    tags = local.basic_tags
  }

  identity {
    type = "SystemAssigned"
  }

  tags = local.basic_tags

  lifecycle {
    ignore_changes = [
      default_node_pool["node_count"]
    ]
  }
}

data "azurerm_container_registry" "acr" {
  name                = "cr${local.service_name_1}"
  resource_group_name = azurerm_resource_group.main.name

  depends_on = [
    azurerm_container_registry.acr
  ]
}

data "azurerm_user_assigned_identity" "kvcsi" {
  name                = "azurekeyvaultsecretsprovider-aks-${local.service_name}"
  resource_group_name = "rg-aks-node-${local.service_name}"
  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}

resource "azurerm_role_assignment" "acrpull_role" {
  scope                            = data.azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  skip_service_principal_aad_check = true
}
