variable "location" {}

variable "rgname_networking" {}

variable "fgt_ext_nic" {}
variable "fgt_int_nic"{}

variable "primary_blob_endpoint" {}

variable "bootstrap-fgtvm" {
  type    = string
  default = "./Network/Fortigate/fgtvm.conf"
}