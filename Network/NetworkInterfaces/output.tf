output "FGT_EXT_NIC_ID" {
  value = azurerm_network_interface.fgtextport1.id
}

output "FGT_INT_NIC_ID" {
  value = azurerm_network_interface.fgtport2.id
}