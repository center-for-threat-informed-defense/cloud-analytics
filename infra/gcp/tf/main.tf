resource "google_compute_instance" "default" {
  name                      = "test"
  machine_type              = var.machine-type
  zone                      = var.zone
  allow_stopping_for_update = true
  tags                      = ["ssh"]
  labels = {
    environment = "test"
    project     = "test"
  }
  boot_disk {
    initialize_params {
      image = var.vm_image
    }
  }
  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
  metadata = {
    ssh-keys = "your ssh keys to login"
  }
}
# allow ssh traffic
resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["47.197.13.27/32"]
  target_tags   = ["ssh"]
}
