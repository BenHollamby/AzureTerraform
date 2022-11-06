resource "azurerm_route_table" "routetable" {
  name = var.Route_Table_Name
  location = var.Location
  resource_group_name = var.RGName_Networking
  disable_bgp_route_propagation = false

  route = [ {
    address_prefix = "0.0.0.0/0"
    name = var.Route_Name
    next_hop_in_ip_address = var.Internal_Next_Hop
    next_hop_type = "VirtualAppliance"
  } ]
}

resource "azurerm_subnet_route_table_association" "VirtualDesktopAssociation" {
  route_table_id = azurerm_route_table.routetable.id
  subnet_id = var.Virtual_Desktop_Subnet_Id
  depends_on = [
    azurerm_route_table.routetable
  ]
}

resource "azurerm_subnet_route_table_association" "InternalAssociation" {
  route_table_id = azurerm_route_table.routetable.id
  subnet_id = var.Internal_Subnet_Id
  depends_on = [
    azurerm_route_table.routetable
  ]
}

resource "azurerm_subnet_route_table_association" "ServerAssociation" {
  route_table_id = azurerm_route_table.routetable.id
  subnet_id = var.Server_Subnet_Id
  depends_on = [
    azurerm_route_table.routetable
  ]
}

resource "azurerm_subnet_route_table_association" "StorageAssociation" {
  route_table_id = azurerm_route_table.routetable.id
  subnet_id = var.Storage_Subnet_Id
  depends_on = [
    azurerm_route_table.routetable
  ]
}

