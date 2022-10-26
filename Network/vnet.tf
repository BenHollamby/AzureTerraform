resource "azurerm_virtual_network" "vnet" {
  address_space = var.vnet_address_space
  resource_group_name = "RG_Networking"
  name = "VN_Core"
  location = var.location
}

resource "azurerm_subnet" "ProtectedSubnet" {
  name           = "sub_Protected"
  resource_group_name = "RG_Networking"
  address_prefixes = [var.sub_Protected]
  virtual_network_name = azurerm_virtual_network.vnet.name

}

resource "azurerm_subnet" "ExternalSubnet" {
  name           = "sub_External"
  resource_group_name = "RG_Networking"
  address_prefixes = [var.sub_External]
  virtual_network_name = azurerm_virtual_network.vnet.name
  
}

resource "azurerm_subnet" "InternalSubnet" {
  name           = "sub_Internal"
  resource_group_name = "RG_Networking"
  address_prefixes = [var.sub_Internal]
  virtual_network_name = azurerm_virtual_network.vnet.name
  
}

resource "azurerm_subnet" "StorageSubnet" {
  name           = "sub_Storage"
  resource_group_name = "RG_Networking"
  address_prefixes = [var.sub_Storage]
  virtual_network_name = azurerm_virtual_network.vnet.name
  
}

resource "azurerm_subnet" "VirtualDesktopSubnet" {
  name           = "sub_VirtualDesktop"
  resource_group_name = "RG_Networking"
  address_prefixes = [var.sub_VirtualDesktop]
  virtual_network_name = azurerm_virtual_network.vnet.name
  
}

resource "azurerm_subnet" "ServerSubnet" {
  name           = "sub_Server"
  resource_group_name = "RG_Networking"
  address_prefixes = [var.sub_Server]
  virtual_network_name = azurerm_virtual_network.vnet.name
  
}

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

resource "azurerm_public_ip" "FGTPublicIp" {
  name                = "FGT-Public-IP"
  location            = var.location
  resource_group_name = "RG_Networking"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "fgtextport1" {
  name                = "EXT-fgtport1"
  location            = var.location
  resource_group_name = "RG_Networking"

  ip_configuration {
    name                          = "ext-ipconfig1"
    subnet_id                     = azurerm_subnet.ExternalSubnet.id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id          = azurerm_public_ip.FGTPublicIp.id
  }
}

resource "azurerm_network_interface" "fgtport2" {
  name                 = "INT-fgtport2"
  location             = var.location
  resource_group_name  = "RG_Networking"
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "int-ipconfig1"
    subnet_id                     = azurerm_subnet.InternalSubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "nsg" {
  name = "NSG_Firewall_External"
  resource_group_name = "RG_Networking"
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
  network_interface_id      = azurerm_network_interface.fgtextport1.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  depends_on = [
    azurerm_network_interface.fgtextport1,
    azurerm_network_security_group.nsg
  ]
}

resource "random_id" "randomId" {
  keepers = {
    resource_group = "RG_Networking"
  }

  byte_length = 8
}

resource "azurerm_storage_account" "fgtstorageaccount" {
  name                     = "diag${random_id.randomId.hex}"
  resource_group_name      = "RG_Networking"
  location                 = var.location
  account_replication_type = "LRS"
  account_tier             = "Standard"
}

resource "azurerm_virtual_machine" "fgtvm" {
  count                        = 1
  name                         = "fgtvm"
  location                     = "australiasoutheast"
  resource_group_name          = "RG_Networking"
  network_interface_ids        = [azurerm_network_interface.fgtextport1.id, azurerm_network_interface.fgtport2.id]
  primary_network_interface_id = azurerm_network_interface.fgtextport1.id
  vm_size                      = "Standard_F4s"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "fortinet"
    offer     = "fortinet_fortigate-vm_v5"
    sku       = "fortinet_fg-vm"
    version   = "7.2.2"
  }

  plan {
    name      = "fortinet_fg-vm"
    publisher = "fortinet"
    product   = "fortinet_fortigate-vm_v5"
  }

  storage_os_disk {
    name              = "osDisk"
    caching           = "ReadWrite"
    managed_disk_type = "Standard_LRS"
    create_option     = "FromImage"
  }

  # Log data disks
  storage_data_disk {
    name              = "fgtvmdatadisk"
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = "30"
  }

  os_profile {
    computer_name  = "fgtvm"
    admin_username = "fortiadmin"
    admin_password = "SuperSecure!"
    custom_data = templatefile("${var.bootstrap-fgtvm}", {
      type         = "byol"
    })

  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = azurerm_storage_account.fgtstorageaccount.primary_blob_endpoint
  }

  tags = {
    environment = "Terraform Demo"
  }

  depends_on = [
    azurerm_subnet.ExternalSubnet,
    azurerm_route_table.routetable,
    azurerm_public_ip.FGTPublicIp,
    azurerm_network_interface.fgtextport1,
    azurerm_network_interface.fgtport2,
    azurerm_network_security_group.nsg,
    azurerm_network_interface_security_group_association.port1nsg,
    azurerm_storage_account.fgtstorageaccount
  ]
}