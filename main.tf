resource "azurerm_resource_group" "rgbackup" {
  name = "RG_Backup"
  location = var.location
}

resource "azurerm_resource_group" "rgserver" {
  name = "RG_Server"
  location = var.location
}

resource "azurerm_resource_group" "rgnetwork" {
  name = "RG_Networking"
  location = var.location
}

resource "azurerm_resource_group" "rgstorage" {
  name = "RG_Storage"
  location = var.location
}

resource "azurerm_resource_group" "rgavd" {
  name = "RG_VirtualDesktop"
  location = var.location
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
    azurerm_resource_group.rgnetwork
  ]
}



