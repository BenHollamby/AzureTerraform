resource "azurerm_resource_group" "rgbackup" {
  name = var.rgname_backup
  location = var.location
}

resource "azurerm_resource_group" "rgserver" {
  name = var.rgname_server
  location = var.location
}

resource "azurerm_resource_group" "rgnetwork" {
  name = var.rgname_networking
  location = var.location
}

resource "azurerm_resource_group" "rgstorage" {
  name = var.rgname_storage
  location = var.location
}

resource "azurerm_resource_group" "rgavd" {
  name = var.rgname_virtualdesktop
  location = var.location
}