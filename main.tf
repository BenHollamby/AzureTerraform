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
  depends_on = [
    module.resourcegroups,
    module.storage
  ]
}

module "nsg" {
  source = "./Network/NSG"
  External_NSG_Name = var.External_NSG_Name
  rgname_networking = var.rgname_networking
  location = var.location
  extnicid = module.NetworkInterfaces.FGT_EXT_NIC_ID
  external_next_hop = var.external_next_hop
  Firewall_Management_Port = var.Firewall_Management_Port
  SSL_VPN_Port = var.SSL_VPN_Port
  depends_on = [
    module.vnet,
    module.NetworkInterfaces
  ]
}

module "NetworkInterfaces" {
  source = "./Network/NetworkInterfaces"
  location = var.location
  rgname_networking = var.rgname_networking
  external_subnet_id = module.vnet.External_Subnet_Id
  internal_subnet_id = module.vnet.Internal_Subnet_Id
  depends_on = [
    module.vnet
  ]
}

module "fortigate" {
  source = "./Network/Fortigate"
  primary_blob_endpoint = module.storage.storageendpoint
  location = var.location
  rgname_networking = var.rgname_networking
  fgt_ext_nic = module.NetworkInterfaces.FGT_EXT_NIC_ID
  fgt_int_nic = module.NetworkInterfaces.FGT_INT_NIC_ID
  
  depends_on = [
    module.resourcegroups,
    module.vnet,
    module.NetworkInterfaces,
    module.nsg,
    module.storage
  ]
}