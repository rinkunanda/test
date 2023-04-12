output "google_network" {
  value = google_compute_network.vpc_network.id
}

ourput "google_subnet" {
  value = google_compute_subnetwork.test_subnetwork.id
}