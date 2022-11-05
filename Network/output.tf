

output "External_Subnet_Id" {
  value = azurerm_subnet.ExternalSubnet.id
}

output "Internal_Subnet_Id" {
  value = azurerm_subnet.InternalSubnet.id
}