// LOCATION
variable "Location" {
  description = "Location of Resources"
  default     = "australiasoutheast" 
}

// VNET ADDRESS
variable "VNet_Address_Space" {
  description = "VNet Address Space"
  default = ["10.0.0.0/16"]
}

// SUBNET ADDRESSES
variable "sub_Protected_Address" {
  description = "Protected Subnet Address Range"
  default = "10.0.10.0/24"
}
variable "sub_External_Address" {
  description = "External Subnet Address Range"
  default = "10.0.11.0/24"
}
variable "sub_Internal_Address" {
  description = "Internal Subnet Address Range"
  default = "10.0.12.0/24"
}
variable "sub_Storage_Address" {
  description = "Storage Subnet Address Range"
  default = "10.0.13.0/24"
}
variable "sub_VirtualDesktop_Address" {
  description = "Virtual Desktop Subnet Address Range"
  default = "10.0.14.0/24"
}
variable "sub_Server_Address" {
  description = "Server Subnet Address Range"
  default = "10.0.15.0/24"
}

// NEXT HOP
variable "Internal_Next_Hop" {
  description = "Next Hop Internal Subnet"
  default = "10.0.12.4"
}
variable "External_Next_Hop" {
  description = "Next Hop IP External Subnet"
  default = "10.0.11.4"
}


// RESOURCE GROUP NAMES
variable "RGName_Backup" {
  description = "Resource Group for Backups"
  default = "RG_Backup"
}
variable "RGName_Networking" {
  description = "Resource Group for Networking"
  default = "RG_Networking"
}
variable "RGName_Server" {
  description = "Resource Group for Servers"
  default = "RG_Server"
}
variable "RGName_Storage" {
  description = "Resource Group for Storage"
  default = "RG_Storage"
}
variable "RGName_VirtualDesktop" {
  description = "Resource Group for Azure Virtual Desktop"
  default = "RG_VirtualDesktop"
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

// MANAGEMENT GROUPS
variable "Root_Group" {
  description = "Root Management Group"
  default = "Root Management Group"
}
variable "Production_Group" {
  description = "Production Group for current subscription"
  default = "Production Management Group"
}



//VNET NAME
variable "VNet_Name" {
  description = "Name of Virtual Network"
  default = "VN_Core"
}


// SUBNET NAMES
variable "Protected_Subnet_Name" {
  description = "Name of Protected Subnet"
  default = "sub_Protected"
}
variable "External_Subnet_Name" {
  description = "External Subnet Name"
  default = "sub_External"
}
variable "Internal_Subnet_Name" {
  description = "Internal Subnet Name"
  default = "sub_Internal"
}
variable "Storage_Subnet_Name" {
  description = "Storage Subnet Name"
  default = "sub_Storage"  
}
variable "VirtualDesktop_Subnet_Name" {
  description = "Azure Virutal Desktop Subnet Name"
  default = "sub_VirtualDesktop"
}
variable "Server_Subnet_Name" {
  description = "Server Subnet Name"
  default = "sub_Server"
}


// ROUTE TABLE and ROUTE NAME
variable "Route_Table_Name" {
  description = "Name of Route Table"
  default = "Route-Table"
}
variable "Route_Name" {
  description = "Default Route Name"
  default = "Default-Route"
}

// FORTIGATE PUBLIC IP NAME
variable "Fortigate_Public_IP_Name" {
  description = "Name of the Fortigate Public IP"
  default = "Fortigate_Public_IP"
}
variable "Fortigate_Public_IP_Allocation_Method" {
  description = "Allocation Method"
  default = "Static"
}

// FORTIGATE EXTERNAL NIC
variable "External_Fortigate_NIC_Name" {
  description = "Fortigate External Network Interface Name"
  default = "External_Fortigate_NIC"
}
variable "External_Fortigate_NIC_Config_Name" {
  description = "Fortigate External NIC Configuration Name"
  default = "External_IP_Config"
}
variable "External_Fortigate_Private_Address_Allocation" {
  description = "External Private Address Allocation"
  default = "Dynamic"
}

// FORTIGATE INTERNAL NIC
variable "Internal_Fortigate_NIC_Name" {
  description = "Fortigate Internal Network Interface Name"
  default = "Internal_Fortigate_NIC"
}
variable "Internal_Fortigate_NIC_Config_Name" {
  description = "Fortigate Internal NIC Configuration Name"
  default = "Internal_IP_Config"
}
variable "Internal_Fortigate_Private_Address_Allocation" {
  description = "Internal Private Address Allocation"
  default = "Dynamic"
}

// FORTIGATE CONFIG
variable "Fortigate_Name" {
  description = "Name of the Fortigate VM and OS Profile Name"
  default = "Fortigate-VM"
}
variable "Fortigate_Size" {
  description = "CPU Type"
  default = "Standard_F2"
}
variable "Fortigate_Username" {
  description = "Fortigate Username"
  sensitive = true
  default = "fortiadmin"
}
variable "Fortigate_Password" {
  description = "Fortigate Password"
  sensitive = true
  default = "SuperSecure!"
}



// AZURE BACKUPS
variable "Azure_Recovery_Services_Vault_Name" {
  description = "Azure Recovery Services Vault Name"
  default = "Prouction-Backups"
}
variable "Storage_Mode_Type" {
  description = "Storage type of Vault"
  default = "LocallyRedundant"
}
variable "Backup_Policy_Name" {
  description = "Backup Policy Name"
  default = "VM-Backup-Policy"
}
variable "Time_Zone" {
  description = "Timezone for vault"
  default = "New Zealand Standard Time"
}
variable "Backup_Frequency" {
  description = "Frequency of backups"
  default = "Daily"
}
variable "Backup_Time" {
  description = "Time of frequency backup"
  default = "23:00"
}
variable "Daily_Retention" {
  description = "Number of daily backup retentions"
  default = 10
}
variable "Weekly_Retention" {
  description = "Number of weekly retentions"
  default = 42
}
variable "Weekly_Retention_Days" {
  description = "Weekly retention days"
  default = ["Sunday", "Wednesday", "Friday", "Saturday"]
}
variable "Monthly_Retention" {
  description = "Number of Monthly retention"
  default = 7
}
variable "Monthly_Retention_Days" {
  description = "Monthly retention days"
  default = ["Sunday", "Wednesday"]
}
variable "Monthly_Retention_Weeks" {
  description = "Monthly retention weeks"
  default = ["First", "Last"]
}
variable "Yearly_Retention" {
  description = "Yearly retention Count"
  default = 7
}
variable "Yearly_Retention_Day" {
  description = "Yearly retention day"
  default = ["Sunday"]
}
variable "Yearly_Retention_Week" {
  description = "Yearly retention week"
  default = ["Last"]
}
variable "Yearly_Retention_Month" {
  description = "Yearly retention month"
  default = ["January"]
}



// az vm image terms accept --publisher fortinet --offer fortinet_fortigate-vm_v5 --plan fortinet_fg-vm