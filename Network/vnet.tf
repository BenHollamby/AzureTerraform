resource "azurerm_virtual_network" "vnet" {
  address_space = var.vnet_address_space
  resource_group_name = "RG_Networking"
  name = "VN_Core"
  location = var.location

  subnet {
    name           = "sub_Protected"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "sub_External"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "sub_Internal"
    address_prefix = "10.0.3.0/24"
  }

  subnet {
    name           = "sub_Storage"
    address_prefix = "10.0.4.0/24"
  }

  subnet {
    name           = "sub_VirtualDesktop"
    address_prefix = "10.0.5.0/24"
  }

  subnet {
    name           = "sub_Server"
    address_prefix = "10.0.6.0/24"
  }
}