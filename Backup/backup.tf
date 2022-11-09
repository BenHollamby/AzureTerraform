resource "azurerm_recovery_services_vault" "vault" {
  name                = var.Azure_Recovery_Services_Vault_Name
  location            = var.Location
  resource_group_name = var.RGName_Backup
  sku                 = "Standard"
  storage_mode_type = var.Storage_Mode_Type
  soft_delete_enabled = true
}

resource "azurerm_backup_policy_vm" "backuppolicy" {
  name                = var.Backup_Policy_Name
  resource_group_name = var.RGName_Backup
  recovery_vault_name = var.Azure_Recovery_Services_Vault_Name

  timezone = var.Time_Zone

  backup {
    frequency = var.Backup_Frequency
    time      = var.Backup_Time
  }

  retention_daily {
    count = var.Daily_Retention
  }

  retention_weekly {
    count    = var.Weekly_Retention
    weekdays = var.Weekly_Retention_Days
  }

  retention_monthly {
    count    = var.Monthly_Retention
    weekdays = var.Monthly_Retention_Days
    weeks    = var.Monthly_Retention_Weeks
  }

  retention_yearly {
    count    = var.Yearly_Retention
    weekdays = var.Yearly_Retention_Day
    weeks    = var.Yearly_Retention_Week
    months   = var.Yearly_Retention_Month
  }
  depends_on = [
    azurerm_recovery_services_vault.vault
  ]
}