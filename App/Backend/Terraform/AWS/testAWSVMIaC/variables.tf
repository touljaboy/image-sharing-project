variable "tags" {
    type        = map(string)
  default     = {
    "Owner"       = "Admin"
    "ImageName"     = "TerraformDemo"
  }
  description = "Testing tags for resources"
}

variable "allowed_ips" {
  type = list(string)
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}