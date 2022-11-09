data "azurerm_subscription" "current" {}

resource "azurerm_subscription_policy_assignment" "backup_governance" {
  name = "Test Policy"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/013e242c-8828-4970-87b3-ab247555486d"
  subscription_id = data.azurerm_subscription.current.id

}

resource "azurerm_management_group_policy_assignment" "name" {
  name = "management-test"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/013e242c-8828-4970-87b3-ab247555486d"
  management_group_id = var.Management_Group_Id
}

// configured to subscription, do I need to move this to the management group instead......
