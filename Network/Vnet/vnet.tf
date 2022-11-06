resource "azurerm_virtual_network" "vnet" {
  address_space = var.VNet_Address_Space
  resource_group_name = var.RGName_Networking
  name = var.VNet_Name
  location = var.Location
}
