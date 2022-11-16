output "storageendpoint" {
  value = azurerm_storage_account.fgtstorageaccount.primary_blob_endpoint
}

output "workspacereadaccessid" {
  value = azurerm_log_analytics_workspace.logworkspace.id
}