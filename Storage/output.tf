output "storageendpoint" {
  value = azurerm_storage_account.fgtstorageaccount.primary_blob_endpoint
}