resource "random_id" "randomId" {
  keepers = {
    resource_group = "RG_Networking"
  }

  byte_length = 8
}

resource "azurerm_storage_account" "fgtstorageaccount" {
  name                     = "diag${random_id.randomId.hex}"
  resource_group_name      = "RG_Networking"
  location                 = var.location
  account_replication_type = "LRS"
  account_tier             = "Standard"
}

output "storageendpoint" {
  value = azurerm_storage_account.fgtstorageaccount.primary_blob_endpoint
}