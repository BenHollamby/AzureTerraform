resource "random_id" "randomId" {
  keepers = {
    resource_group = var.RGName_Storage
  }
  byte_length = 8
}

resource "azurerm_storage_account" "fgtstorageaccount" {
  name                     = "forti${random_id.randomId.hex}"
  resource_group_name      = var.RGName_Storage
  location                 = var.Location
  account_replication_type = "LRS"
  account_tier             = "Standard"
}

resource "azurerm_log_analytics_workspace" "logworkspace" {
  name = var.Log_Analytics_Name
  location = var.Location
  resource_group_name = var.RGName_Storage
  sku = var.SKU
  retention_in_days = var.Retention_In_Days
}