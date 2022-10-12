variable "location" {
    default     = "australiasoutheast"
    description = "location of resources"
}

variable "vnet_address_space" {
  description = "vnet"
  default = ["10.0.0.0/16"]
}
