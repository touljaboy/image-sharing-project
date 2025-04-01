terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.93.0"
    }
    cloudinit = {
      source = "hashicorp/cloudinit"
      version = "2.3.7-alpha.2"
    }
  }
}

provider "aws" {
  profile = "default" 
  region  = "eu-north-1"
}

provider "cloudinit" {
  # Configuration options
}