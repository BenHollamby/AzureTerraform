resource "azurerm_virtual_network" "vnet" {
  address_space = var.vnet_address_space
  resource_group_name = var.rgname_networking
  name = "VN_Core"
  location = var.location
}

resource "azurerm_subnet" "ProtectedSubnet" {
  name           = "sub_Protected"
  resource_group_name = var.rgname_networking
  address_prefixes = [var.sub_Protected]
  virtual_network_name = azurerm_virtual_network.vnet.name

}

resource "azurerm_subnet" "ExternalSubnet" {
  name           = "sub_External"
  resource_group_name = var.rgname_networking
  address_prefixes = [var.sub_External]
  virtual_network_name = azurerm_virtual_network.vnet.name
  
}

resource "azurerm_subnet" "InternalSubnet" {
  name           = "sub_Internal"
  resource_group_name = var.rgname_networking
  address_prefixes = [var.sub_Internal]
  virtual_network_name = azurerm_virtual_network.vnet.name
  
}

resource "azurerm_subnet" "StorageSubnet" {
  name           = "sub_Storage"
  resource_group_name = var.rgname_networking
  address_prefixes = [var.sub_Storage]
  virtual_network_name = azurerm_virtual_network.vnet.name
  
}

resource "azurerm_subnet" "VirtualDesktopSubnet" {
  name           = "sub_VirtualDesktop"
  resource_group_name = var.rgname_networking
  address_prefixes = [var.sub_VirtualDesktop]
  virtual_network_name = azurerm_virtual_network.vnet.name
  
}

resource "azurerm_subnet" "ServerSubnet" {
  name           = "sub_Server"
  resource_group_name = var.rgname_networking
  address_prefixes = [var.sub_Server]
  virtual_network_name = azurerm_virtual_network.vnet.name
  
}

resource "azurerm_route_table" "routetable" {
  name = "Route-Table"
  location = var.location
  resource_group_name = var.rgname_networking
  disable_bgp_route_propagation = false

  route = [ {
    address_prefix = "0.0.0.0/0"
    name = "default-route"
    next_hop_in_ip_address = var.internal_next_hop
    next_hop_type = "VirtualAppliance"
  } ]
}

resource "azurerm_subnet_route_table_association" "VirtualDesktopAssociation" {
  route_table_id = azurerm_route_table.routetable.id
  subnet_id = azurerm_subnet.VirtualDesktopSubnet.id
  depends_on = [
    azurerm_virtual_network.vnet,
    azurerm_route_table.routetable
  ]
}

resource "azurerm_subnet_route_table_association" "InternalAssociation" {
  route_table_id = azurerm_route_table.routetable.id
  subnet_id = azurerm_subnet.InternalSubnet.id
  depends_on = [
    azurerm_virtual_network.vnet,
    azurerm_route_table.routetable
  ]
}

resource "azurerm_subnet_route_table_association" "ServerAssociation" {
  route_table_id = azurerm_route_table.routetable.id
  subnet_id = azurerm_subnet.ServerSubnet.id
  depends_on = [
    azurerm_virtual_network.vnet,
    azurerm_route_table.routetable
  ]
}

resource "azurerm_subnet_route_table_association" "StorageAssociation" {
  route_table_id = azurerm_route_table.routetable.id
  subnet_id = azurerm_subnet.StorageSubnet.id
  depends_on = [
    azurerm_virtual_network.vnet,
    azurerm_route_table.routetable
  ]
}

