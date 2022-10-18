module "resourcegroups" {
  source = "./ResourceGroups"
  location = var.location
  rgname_backup = var.rgname_backup
  rgname_networking = var.rgname_networking
  rgname_server = var.rgname_server
  rgname_storage = var.rgname_storage
  rgname_virtualdesktop = var.rgname_virtualdesktop
}

module "vnet" {
  source = "./Network"
  vnet_address_space = var.vnet_address_space
  location = var.location
  sub_Protected = var.sub_Protected
  sub_External = var.sub_External
  sub_Internal = var.sub_Internal
  sub_Storage = var.sub_Storage
  sub_VirtualDesktop = var.sub_VirtualDesktop
  sub_Server = var.sub_Server
  
  depends_on = [
    module.resourcegroups
  ]
}

module "nsg" {
  source = "./NSG"
  location = var.location
  external_next_hop = var.external_next_hop

  depends_on = [
    module.resourcegroups
  ]
}

module "routetable" {
  source = "./RouteTable"
  location = var.location
  internal_next_hop = var.internal_next_hop

  depends_on = [
    module.resourcegroups,
    module.vnet
  ]
}

data "azurerm_subnet" "testsubnet" {
  name = "sub_Internal"
  virtual_network_name = "vnet"
  resource_group_name = "RG_Networking"
}

output "subnet_id" {
  value = data.azurerm_subnet.testsubnet.id
}
