resource "azurerm_virtual_network" "vnet" {
  address_space = var.vnet
  resource_group_name = "RG_Networking"
  name = "VN_Core"
  location = var.location
}