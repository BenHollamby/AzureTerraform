data "azurerm_subscription" "current" {}

resource "azurerm_management_group_policy_assignment" "backup_governance" {
  name = "Azure-Backup-Policy"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/013e242c-8828-4970-87b3-ab247555486d"
  management_group_id = var.Management_Group_Id
}

resource "azurerm_management_group_policy_assignment" "backup_remediation" {
  name = "Backup-Remediation"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/09ce66bc-1220-4153-8104-e3f51c936913"
  management_group_id = var.Management_Group_Id
  location = var.Location
  identity {
    type = "SystemAssigned"
  }
  parameters = <<PARAMETERS
  {
    "vaultLocation": {
      "value": "${var.Location}"
    },
    "backupPolicyId": {
      "value": "${var.policy}"
    }
  }
PARAMETERS
}

resource "azurerm_management_group_policy_assignment" "azure_monitor" {
  name = "Azure-Monitor-Policy"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/17b3de92-f710-4cf4-aa55-0e7859f1ed7b"
  management_group_id = var.Management_Group_Id
  identity {
    type = "SystemAssigned"
  }
  location = var.Location
}
