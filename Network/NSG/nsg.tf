resource "azurerm_network_security_group" "nsg" {
  name = var.External_NSG_Name
  resource_group_name = var.RGName_Networking
  location = var.Location

  security_rule {
      name                       = "All_Traffic"
      priority                   = 140
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = var.External_Next_Hop
  }

  security_rule {
    name                       = "Allow_FW_Management"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.Firewall_Management_Port
    source_address_prefix      = "*"
    destination_address_prefix = var.External_Next_Hop
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
    destination_address_prefix = var.External_Next_Hop
  }

  security_rule {
    name                       = "Fortigate_SSL_VPN"
    priority                   = 180
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.SSL_VPN_Port
    source_address_prefix      = "*"
    destination_address_prefix = var.External_Next_Hop
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