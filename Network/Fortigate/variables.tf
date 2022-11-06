variable "Location" {}
variable "RGName_Networking" {}
variable "fgt_ext_nic" {}
variable "fgt_int_nic"{}
variable "primary_blob_endpoint" {}
variable "Fortigate_Name" {}
variable "Fortigate_Size" {}
variable "Fortigate_Username" {}
variable "Fortigate_Password" {}
variable "bootstrap-fgtvm" {
  type    = string
  default = "./Network/Fortigate/fgtvm.conf"
}