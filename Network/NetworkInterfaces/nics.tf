resource "azurerm_public_ip" "FGTPublicIp" {
  name                = var.Fortigate_Public_IP_Name
  location            = var.Location
  resource_group_name = var.RGName_Networking
  allocation_method   = var.Fortigate_Public_IP_Allocation_Method
}

resource "azurerm_network_interface" "fgtextport1" {
  name                = var.External_Fortigate_NIC_Name
  location            = var.Location
  resource_group_name = var.RGName_Networking

  ip_configuration {
    name                          = var.External_Fortigate_NIC_Config_Name
    subnet_id                     = var.external_subnet_id
    private_ip_address_allocation = var.External_Fortigate_Private_Address_Allocation
    primary                       = true
    public_ip_address_id          = azurerm_public_ip.FGTPublicIp.id
  }
}

resource "azurerm_network_interface" "fgtport2" {
  name                 = var.Internal_Fortigate_NIC_Name
  location             = var.Location
  resource_group_name  = var.RGName_Networking
  enable_ip_forwarding = true

  ip_configuration {
    name                          = var.Internal_Fortigate_NIC_Config_Name
    subnet_id                     = var.internal_subnet_id
    private_ip_address_allocation = var.Internal_Fortigate_Private_Address_Allocation
  }
}