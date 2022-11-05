resource "azurerm_public_ip" "FGTPublicIp" {
  name                = "FGT-Public-IP"
  location            = var.location
  resource_group_name = var.rgname_networking
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "fgtextport1" {
  name                = "EXT-fgtport1"
  location            = var.location
  resource_group_name = var.rgname_networking

  ip_configuration {
    name                          = "ext-ipconfig1"
    subnet_id                     = var.external_subnet_id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id          = azurerm_public_ip.FGTPublicIp.id
  }
}

resource "azurerm_network_interface" "fgtport2" {
  name                 = "INT-fgtport2"
  location             = var.location
  resource_group_name  = var.rgname_networking
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "int-ipconfig1"
    subnet_id                     = var.internal_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}