terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.27.0"
    }
    cloudinit = {
      source = "hashicorp/cloudinit"
      version = "2.3.7-alpha.2"
    }
  }
}

provider "google" {
  project = var.project
  region = "us-central1"
  zone = "us-central1-c"
}

provider "cloudinit" {
  # Configuration options
}