resource "azurerm_automation_account" "automationaccount" {
  name                = var.Automation_Account_Name
  location            = var.Location
  resource_group_name = var.RGName_Automation
  sku_name            = "Basic"
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_log_analytics_linked_service" "automationlink" {
  resource_group_name = var.RGName_Storage
  read_access_id = azurerm_automation_account.automationaccount.id
  workspace_id = var.Workspace_ID
}