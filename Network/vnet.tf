resource "azurerm_virtual_network" "vnet" {
  address_space = var.vnet_address_space
  resource_group_name = "RG_Networking"
  name = "VN_Core"
  location = var.location

  subnet {
    name           = "sub_Protected"
    address_prefix = var.sub_Protected
  }

  subnet {
    name           = "sub_External"
    address_prefix = var.sub_External
  }

  subnet {
    name           = "sub_Internal"
    address_prefix = var.sub_Internal
  }

  subnet {
    name           = "sub_Storage"
    address_prefix = var.sub_Storage
  }

  subnet {
    name           = "sub_VirtualDesktop"
    address_prefix = var.sub_VirtualDesktop
  }

  subnet {
    name           = "sub_Server"
    address_prefix = var.sub_Server
  }
}