resource "google_sql_database_instance" "instance" {
  name        = var.db_name
  project     = var.project
  region      = var.region
  database_version = var.db_version
  
  settings {
    tier var.tier
	ip_configuration {
	  ipv4_enabled  = false
	  private_network = var.network
	}
  }
}