module "resourcegroups" {
  source = "./ResourceGroups"
  Location = var.Location
  RGName_Backup = var.RGName_Backup
  RGName_Networking = var.RGName_Networking
  RGName_Server = var.RGName_Server
  RGName_Storage = var.RGName_Storage
  RGName_VirtualDesktop = var.RGName_VirtualDesktop
}

module "storage" {
  source = "./Storage"
  Location = var.Location
  RGName_Networking = var.RGName_Networking
  depends_on = [
    module.resourcegroups
  ]
}

module "vnet" {
  source = "./Network/Vnet"
  Location = var.Location
  VNet_Name = var.VNet_Name
  VNet_Address_Space = var.VNet_Address_Space
  RGName_Networking = var.RGName_Networking
  depends_on = [
   module.resourcegroups 
  ]
}

module "subnets" {
  source = "./Network/Subnets"
  RGName_Networking = var.RGName_Networking
  VNet_Name = module.vnet.vnetname
  Location = var.Location
  External_Subnet_Name = var.External_Subnet_Name
  sub_External_Address = var.sub_External_Address
  Internal_Subnet_Name = var.Internal_Subnet_Name
  sub_Internal_Address = var.sub_Internal_Address
  Protected_Subnet_Name = var.Protected_Subnet_Name
  sub_Protected_Address = var.sub_Protected_Address
  Server_Subnet_Name = var.Server_Subnet_Name
  sub_Server_Address = var.sub_Server_Address
  Storage_Subnet_Name = var.Storage_Subnet_Name
  sub_Storage_Address = var.sub_Storage_Address
  VirtualDesktop_Subnet_Name = var.VirtualDesktop_Subnet_Name
  sub_VirtualDesktop_Address = var.sub_VirtualDesktop_Address
  depends_on = [
    module.vnet
  ]
}

module "routetable" {
  source = "./Network/Routetable"
  Location = var.Location
  Route_Table_Name = var.Route_Table_Name
  Route_Name = var.Route_Name
  RGName_Networking = var.RGName_Networking
  Internal_Next_Hop = var.Internal_Next_Hop
  External_Next_Hop = var.External_Next_Hop
  Virtual_Desktop_Subnet_Id = module.subnets.Virtual_Desktop_Subnet_Id
  Internal_Subnet_Id = module.subnets.Internal_Subnet_Id
  Server_Subnet_Id = module.subnets.Server_Subnet_Id
  Storage_Subnet_Id = module.subnets.Storage_Subnet_Id
  depends_on = [
    module.subnets
  ]
}

module "nsg" {
  source = "./Network/NSG"
  External_NSG_Name = var.External_NSG_Name
  RGName_Networking = var.RGName_Networking
  Location = var.Location
  extnicid = module.NetworkInterfaces.FGT_EXT_NIC_ID
  External_Next_Hop = var.External_Next_Hop
  Firewall_Management_Port = var.Firewall_Management_Port
  SSL_VPN_Port = var.SSL_VPN_Port
  depends_on = [
    module.vnet,
    module.subnets,
    module.NetworkInterfaces
  ]
}

module "NetworkInterfaces" {
  source = "./Network/NetworkInterfaces"
  Location = var.Location
  RGName_Networking = var.RGName_Networking
  Fortigate_Public_IP_Name = var.Fortigate_Public_IP_Name
  Fortigate_Public_IP_Allocation_Method = var.Fortigate_Public_IP_Allocation_Method
  External_Fortigate_NIC_Name = var.External_Fortigate_NIC_Name
  External_Fortigate_NIC_Config_Name = var.External_Fortigate_NIC_Config_Name
  External_Fortigate_Private_Address_Allocation = var.External_Fortigate_Private_Address_Allocation
  Internal_Fortigate_NIC_Name = var.Internal_Fortigate_NIC_Name
  Internal_Fortigate_NIC_Config_Name = var.Internal_Fortigate_NIC_Config_Name
  Internal_Fortigate_Private_Address_Allocation = var.Internal_Fortigate_Private_Address_Allocation
  external_subnet_id = module.subnets.External_Subnet_Id
  internal_subnet_id = module.subnets.Internal_Subnet_Id
  depends_on = [
    module.vnet
  ]
}

module "fortigate" {
  source = "./Network/Fortigate"
  primary_blob_endpoint = module.storage.storageendpoint
  Location = var.Location
  RGName_Networking = var.RGName_Networking
  fgt_ext_nic = module.NetworkInterfaces.FGT_EXT_NIC_ID
  fgt_int_nic = module.NetworkInterfaces.FGT_INT_NIC_ID
  Fortigate_Name = var.Fortigate_Name
  Fortigate_Size = var.Fortigate_Size
  Fortigate_Username = var.Fortigate_Username
  Fortigate_Password = var.Fortigate_Password
  depends_on = [
    module.resourcegroups,
    module.storage,
    module.vnet,
    module.subnets,
    module.NetworkInterfaces,
    module.routetable,
    module.nsg
  ]
}

module "managementgroups" {
  source = "./Governance/ManagementGroups"
  Root_Group = var.Root_Group
  Production_Group = var.Production_Group
}

module "backup" {
  source = "./Backup"
  Azure_Recovery_Services_Vault_Name = var.Azure_Recovery_Services_Vault_Name
  Location = var.Location
  RGName_Backup = var.RGName_Backup
  Storage_Mode_Type = var.Storage_Mode_Type
  Backup_Policy_Name = var.Backup_Policy_Name
  Time_Zone = var.Time_Zone
  Backup_Frequency = var.Backup_Frequency
  Backup_Time = var.Backup_Time
  Daily_Retention = var.Daily_Retention
  Weekly_Retention = var.Weekly_Retention
  Weekly_Retention_Days = var.Weekly_Retention_Days
  Monthly_Retention = var.Monthly_Retention
  Monthly_Retention_Days = var.Monthly_Retention_Days
  Monthly_Retention_Weeks = var.Monthly_Retention_Weeks
  Yearly_Retention = var.Yearly_Retention
  Yearly_Retention_Day = var.Yearly_Retention_Day
  Yearly_Retention_Week = var.Yearly_Retention_Week
  Yearly_Retention_Month = var.Yearly_Retention_Month
  depends_on = [
    module.resourcegroups
  ]
}

module "policy" {
  source = "./Governance/Policies"
  Management_Group_Id = module.managementgroups.Management_Production_Group_Id
  Location = var.Location
}


