resource "azurerm_subnet" "ProtectedSubnet" {
  name           = var.Protected_Subnet_Name
  resource_group_name = var.RGName_Networking
  address_prefixes = [var.sub_Protected_Address]
  virtual_network_name = var.VNet_Name

}

resource "azurerm_subnet" "ExternalSubnet" {
  name           = var.External_Subnet_Name
  resource_group_name = var.RGName_Networking
  address_prefixes = [var.sub_External_Address]
  virtual_network_name = var.VNet_Name
  
}

resource "azurerm_subnet" "InternalSubnet" {
  name           = var.Internal_Subnet_Name
  resource_group_name = var.RGName_Networking
  address_prefixes = [var.sub_Internal_Address]
  virtual_network_name = var.VNet_Name
  
}

resource "azurerm_subnet" "StorageSubnet" {
  name           = var.Storage_Subnet_Name
  resource_group_name = var.RGName_Networking
  address_prefixes = [var.sub_Storage_Address]
  virtual_network_name = var.VNet_Name
  
}

resource "azurerm_subnet" "VirtualDesktopSubnet" {
  name           = var.VirtualDesktop_Subnet_Name
  resource_group_name = var.RGName_Networking
  address_prefixes = [var.sub_VirtualDesktop_Address]
  virtual_network_name = var.VNet_Name
  
}

resource "azurerm_subnet" "ServerSubnet" {
  name           = var.Server_Subnet_Name
  resource_group_name = var.RGName_Networking
  address_prefixes = [var.sub_Server_Address]
  virtual_network_name = var.VNet_Name
  
}