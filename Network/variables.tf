
variable "vnet_address_space" {
  description = "vnet"
}
variable "location" {
  description = "location"
}

variable "sub_Protected" {
  description = "protected subnet"
}

variable "sub_External" {
  description = "protected subnet"
}

variable "sub_Internal" {
  description = "protected subnet"
}

variable "sub_Storage" {
  description = "protected subnet"
}

variable "sub_VirtualDesktop" {
  description = "protected subnet"
}

variable "sub_Server" {}

variable "rgname_networking" {
}

variable "internal_next_hop" {}

variable "external_next_hop" {}

variable "bootstrap-fgtvm" {
  type    = string
  default = "./Network/fgtvm.conf"
}

variable "primary_blob_endpoint" {
  
}