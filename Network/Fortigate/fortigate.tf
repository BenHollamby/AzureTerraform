

resource "azurerm_virtual_machine" "fgtvm" {
  count                        = 1
  name                         = "fgtvm"
  location                     = var.location
  resource_group_name          = var.rgname_networking
  network_interface_ids        = [var.fgt_ext_nic, var.fgt_int_nic]
  primary_network_interface_id = var.fgt_ext_nic
  vm_size                      = "Standard_F4s"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "fortinet"
    offer     = "fortinet_fortigate-vm_v5"
    sku       = "fortinet_fg-vm"
    version   = "7.2.2"
  }

  plan {
    name      = "fortinet_fg-vm"
    publisher = "fortinet"
    product   = "fortinet_fortigate-vm_v5"
  }

  storage_os_disk {
    name              = "osDisk"
    caching           = "ReadWrite"
    managed_disk_type = "Standard_LRS"
    create_option     = "FromImage"
  }

  # Log data disks
  storage_data_disk {
    name              = "fgtvmdatadisk"
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = "30"
  }

  os_profile {
    computer_name  = "fgtvm"
    admin_username = "fortiadmin"
    admin_password = "SuperSecure!"
    custom_data = templatefile("${var.bootstrap-fgtvm}", {
      type         = "byol"
    })

  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = var.primary_blob_endpoint
  }
}