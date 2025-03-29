variable "project" {
    type = string
}

variable "tags" {
    type        = map(string)
  default     = {
    "Owner"       = "Admin"
    "ImageName"     = "TerraformDemo"
  }
  description = "Testing tags for resources"
}