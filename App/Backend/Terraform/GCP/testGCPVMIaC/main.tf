resource "google_compute_instance" "vm_instance" {
  name         = "my-instance"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  metadata_startup_script = file("${path.module}/startup.sh")

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  # TODO ADD A VPC and configure and stuff
}
