data "azurerm_subscription" "current" {
}

resource "azurerm_management_group" "rootmanagementgroup" {
  display_name = var.Root_Group
}

resource "azurerm_management_group" "productiongroup" {
  display_name               = var.Production_Group
  parent_management_group_id = azurerm_management_group.rootmanagementgroup.id

  subscription_ids = [
    data.azurerm_subscription.current.subscription_id
  ]
}