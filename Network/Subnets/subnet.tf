resource "azurerm_subnet" "ProtectedSubnet" {
  name           = "sub_Protected"
  resource_group_name = var.rgname_networking
  address_prefixes = [var.sub_Protected]
  virtual_network_name = var.vnet_name

}

resource "azurerm_subnet" "ExternalSubnet" {
  name           = "sub_External"
  resource_group_name = var.rgname_networking
  address_prefixes = [var.sub_External]
  virtual_network_name = var.vnet_name
  
}

resource "azurerm_subnet" "InternalSubnet" {
  name           = "sub_Internal"
  resource_group_name = var.rgname_networking
  address_prefixes = [var.sub_Internal]
  virtual_network_name = var.vnet_name
  
}

resource "azurerm_subnet" "StorageSubnet" {
  name           = "sub_Storage"
  resource_group_name = var.rgname_networking
  address_prefixes = [var.sub_Storage]
  virtual_network_name = var.vnet_name
  
}

resource "azurerm_subnet" "VirtualDesktopSubnet" {
  name           = "sub_VirtualDesktop"
  resource_group_name = var.rgname_networking
  address_prefixes = [var.sub_VirtualDesktop]
  virtual_network_name = var.vnet_name
  
}

resource "azurerm_subnet" "ServerSubnet" {
  name           = "sub_Server"
  resource_group_name = var.rgname_networking
  address_prefixes = [var.sub_Server]
  virtual_network_name = var.vnet_name
  
}