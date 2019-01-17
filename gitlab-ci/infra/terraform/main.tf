provider "google" {
 version = "1.4.0"
 project = "${var.project}"
 region = "${var.proj_zone}"
}
resource "google_compute_instance" "gitlab-ci" {
  name         = "gitlab-ci-1"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"
  
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
      size = "100"
      type = "pd-standard"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  tags = ["gitlab-server"]

  network_interface {
    network = "default"
    access_config {}
  }
}

resource "google_compute_firewall" "firewall_gitlab" {
  name = "gitlab-default"

  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["gitlab-server"]
}
