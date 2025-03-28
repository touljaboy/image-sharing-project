variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "test-rg"
}

variable "nwrg_resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "NetworkWatcherRG"
}

variable "location" {
  description = "The Azure region"
  type        = string
  default     = "Poland Central"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
