output "External_Subnet_Id" {
  value = azurerm_subnet.ExternalSubnet.id
}
output "Internal_Subnet_Id" {
  value = azurerm_subnet.InternalSubnet.id
}
output "Virtual_Desktop_Subnet_Id" {
  value = azurerm_subnet.VirtualDesktopSubnet.id
}
output "Server_Subnet_Id" {
  value = azurerm_subnet.ServerSubnet.id
}
output "Storage_Subnet_Id" {
  value = azurerm_subnet.StorageSubnet.id
}