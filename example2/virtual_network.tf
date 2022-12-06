resource "azurerm_virtual_network" "aks" {
  name                = "vnet-${terraform.workspace}-${azurerm_resource_group.main.location}-aks-001"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = [var.virtual_network.address_space]

  tags = local.basic_tags
}

resource "azurerm_subnet" "aks_1" {
  name                 = "snet-${terraform.workspace}-${azurerm_resource_group.main.location}-aks-001"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = [var.virtual_network.address_prefixes_subnet1]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage", "Microsoft.KeyVault"]
}

resource "azurerm_subnet" "aks_2" {
  name                 = "snet-${terraform.workspace}-${azurerm_resource_group.main.location}-aks-002"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = [var.virtual_network.address_prefixes_subnet2]

  delegation {
    name = "aciDelegation"
    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
