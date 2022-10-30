resource "azurerm_network_security_group" "nsg" {
  name = "NSG_Firewall_External"
  resource_group_name = var.rgname_networking
  location = var.location

  security_rule {
    name                       = "All_Traffic"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = var.external_next_hop
  }

  security_rule {
    name                       = "Allow_FW_Management"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "11443"
    source_address_prefix      = "*"
    destination_address_prefix = var.external_next_hop
  }

  security_rule {
    name                       = "Allow_ICMP"
    priority                   = 151
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = var.external_next_hop
  }

  security_rule {
    name                       = "Fortigate_SSL_VPN"
    priority                   = 180
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9443"
    source_address_prefix      = "*"
    destination_address_prefix = var.external_next_hop
  }

  security_rule {
    name                       = "Deny_All"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Connect the security group to the network interfaces
resource "azurerm_network_interface_security_group_association" "port1nsg" {
  network_interface_id      = var.extnicid
  network_security_group_id = azurerm_network_security_group.nsg.id
}