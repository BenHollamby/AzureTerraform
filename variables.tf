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
    description = "location of resources"
}


// VNET
variable "vnet_address_space" {
  description = "vnet"
  default = ["10.0.0.0/16"]
}


// SUBNETS
variable "sub_Protected" {
  description = "protected subnet"
  default = "10.0.10.0/24"
}

variable "sub_External" {
  description = "protected subnet"
  default = "10.0.11.0/24"
}

variable "sub_Internal" {
  description = "protected subnet"
  default = "10.0.12.0/24"
}

variable "sub_Storage" {
  description = "protected subnet"
  default = "10.0.13.0/24"
}

variable "sub_VirtualDesktop" {
  description = "protected subnet"
  default = "10.0.14.0/24"
}

variable "sub_Server" {
  description = "protected subnet"
  default = "10.0.15.0/24"
}


// NEXT HOP
variable "internal_next_hop" {
  description = "next hop internal subnet"
  default = "10.0.12.4"
}

variable "external_next_hop" {
  description = "next hop IP external subnet"
  default = "10.0.11.4"
}


// az vm image terms accept --publisher fortinet --offer fortinet_fortigate-vm_v5 --plan fortinet_fg-vm