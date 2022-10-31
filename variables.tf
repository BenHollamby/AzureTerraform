// RESOURCE GROUPS
variable "rgname_backup" {
  default = "RG_Backup"
}

variable "rgname_networking" {
  default = "RG_Networking"
}

variable "rgname_server" {
  default = "RG_Server"
}

variable "rgname_storage" {
  default = "RG_Storage"
}

variable "rgname_virtualdesktop" {
  default = "RG_VirtualDesktop"
}

variable "location" {
    default     = "australiasoutheast"
    description = "Location of Resources"
}


// VNET
variable "vnet_address_space" {
  description = "VNet Address Space"
  default = ["10.0.0.0/16"]
}


// SUBNETS
variable "sub_Protected" {
  description = "Protected Subnet"
  default = "10.0.10.0/24"
}

variable "sub_External" {
  description = "External Subnet"
  default = "10.0.11.0/24"
}

variable "sub_Internal" {
  description = "Internal Subnet"
  default = "10.0.12.0/24"
}

variable "sub_Storage" {
  description = "Storage Subnet"
  default = "10.0.13.0/24"
}

variable "sub_VirtualDesktop" {
  description = "Virtual Desktop Subnet"
  default = "10.0.14.0/24"
}

variable "sub_Server" {
  description = "Server Subnet"
  default = "10.0.15.0/24"
}


// NEXT HOP
variable "internal_next_hop" {
  description = "Next Hop Internal Subnet"
  default = "10.0.12.4"
}

variable "external_next_hop" {
  description = "Next Hop IP External Subnet"
  default = "10.0.11.4"
}

// Firewall Management
variable "External_NSG_Name" {
  default = "NSG_Firewall_External"
}

variable "Firewall_Management_Port" {
  default = "11443"
}

variable "SSL_VPN_Port" {
  default = "9443"
}

// az vm image terms accept --publisher fortinet --offer fortinet_fortigate-vm_v5 --plan fortinet_fg-vm