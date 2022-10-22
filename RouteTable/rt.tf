resource "azurerm_route_table" "routetable" {
  name = "Route-Table"
  location = var.location
  resource_group_name = "RG_Networking"
  disable_bgp_route_propagation = false

  route = [ {
    address_prefix = "0.0.0.0/0"
    name = "default-route"
    next_hop_in_ip_address = var.internal_next_hop
    next_hop_type = "VirtualAppliance"
  } ]
}