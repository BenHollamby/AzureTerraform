module "resourcegroups" {
  source = "./ResourceGroups"
  location = var.location
  rgname_backup = var.rgname_backup
  rgname_networking = var.rgname_networking
  rgname_server = var.rgname_server
  rgname_storage = var.rgname_storage
  rgname_virtualdesktop = var.rgname_virtualdesktop
}

module "storage" {
  source = "./Storage"
  location = var.location
  rgname_networking = var.rgname_networking
  depends_on = [
    module.resourcegroups
  ]
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
  internal_next_hop = var.internal_next_hop
  external_next_hop = var.external_next_hop
  rgname_networking = var.rgname_networking
  primary_blob_endpoint = module.storage.storageendpoint
  
  depends_on = [
    module.resourcegroups,
    module.storage
  ]
}

module "nsg" {
  source = "./Network/NSG"
  rgname_networking = var.rgname_networking
  location = var.location
  extnicid = module.vnet.FGT_EXT_NIC_ID
  external_next_hop = var.external_next_hop
  depends_on = [
    module.vnet
  ]
}
