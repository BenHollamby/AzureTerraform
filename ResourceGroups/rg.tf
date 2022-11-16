resource "azurerm_resource_group" "rgbackup" {
  name = var.RGName_Backup
  location = var.Location
}

resource "azurerm_resource_group" "rgserver" {
  name = var.RGName_Server
  location = var.Location
}

resource "azurerm_resource_group" "rgnetwork" {
  name = var.RGName_Networking
  location = var.Location
}

resource "azurerm_resource_group" "rgstorage" {
  name = var.RGName_Storage
  location = var.Location
}

resource "azurerm_resource_group" "rgavd" {
  name = var.RGName_VirtualDesktop
  location = var.Location
}

resource "azurerm_resource_group" "rgautomation" {
  name = var.RGName_Automation
  location = var.Location
}