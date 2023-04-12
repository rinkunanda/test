data "google_compute_subnetwork" "test_subnet"
  name = var.subnetwork
  region = var.region
}

resource "google_compute_instance" "google_instance" {
  project = var.project
  zone = var.zone
  name = var.instance_name
  machine_type = var.machine_type
  tags = var.tags
  metadata = var.metadata
  metadata_startup_script = var.metadata_startup_script
  boot_disk {
    device_name = var.instance_name
	initialize_params {
	  image = var.image
	  size = var.boot_disk_size
	  type = var.boot_disk_type
	}
  }
  network_interface {
    network = data.google_compute_subnetwork.test_subnet.network
  }
}

resource "google_dns_record_set" "a_record" {
  project = var.project
  name = var.dns_name
  type = var.type
  managed_zone = var.mamaged_zone
  rrdatas = var.rrdatas
  ttl = var.ttl
}