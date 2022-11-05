resource "azurerm_virtual_network" "vnet" {
  address_space = var.vnet_address_space
  resource_group_name = var.rgname_networking
  name = "VN_Core"
  location = var.location
}
