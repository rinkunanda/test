resouce "google_compute_url_map" "url_map"
  name           = var.url_map
  project        = var.project
  region         = var.region
  
  host_rule {
    hosts        = [var.hosturl]
	path_matcher = var.path_matcher
  }
  
  path_matcher {
    name         = var.path_matcher
	default_service  = var.backend_service
	path_rule {
	  paths     = var.path_rule
	  service   = var.backend_service
	}
  }
}

resource "google_compute_target_http_proxy" "target_proxy" {
  name     = var.target_proxy
  depends_on = [google_compute_url_map.url_map]
  project  = var.project
  region   = var.region
  url_map  = google_compute_url_map.url_map.id
  
resource "google_compute_forwarding_rule" "google_forwarding_rule"
  project = var.project
  depends_on = [google_compute_target_http_proxy.target_proxy]
  name = var.forward_rule_name
  region = var.region
  subnetwork = var.subnetwork
  allow_global_access = var.global_access
  load_balancing_scheme = "EXTERNAL"
  ip_protocol = var.frontend_protocol
  port_range = var.frontend_port
  target = google_compute_target_http_proxy.target_proxy.id
  
resource "google_dns_record_set" "lb_set_dns" {
  project = var.dns_project
  name = var.dns_name
  type = var.dns_type
  managed_zone = var.managed_zone
  rrdatas = [google_compute_forwarding_rule.google_forwarding_rule.ip_address]
  ttl = var.dns_ttl
}

resource "google_dns_record_set" "lb_set_cname"
  project = var.dns_project
  name = var.dns_name
  type = var.cname_type
  managed_zone = var.managed_zone
  rrdatas = var.rrdatas
  ttl = var.cname_ttl
}
  