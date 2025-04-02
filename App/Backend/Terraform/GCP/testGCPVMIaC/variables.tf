variable "project" {
    type = string
}

variable "tags" {
    type        = map(string)
  default     = {
    "Owner"       = "Admin"
    "ImageName"     = "TerraformDemo"
  }
  description = "Test tags for resources"
}

variable "allowed_ips" {
  type = list(string)
  description = "It's your ip or any other that you will to allow. It is a list of strings."
}