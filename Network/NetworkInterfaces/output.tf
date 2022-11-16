output "FGT_EXT_NIC_ID" {
  value = azurerm_network_interface.fgtextport1.id
}

output "FGT_INT_NIC_ID" {
  value = azurerm_network_interface.fgtport2.id
}

output "PublicIP" {
  value = azurerm_public_ip.FGTPublicIp.ip_address
}