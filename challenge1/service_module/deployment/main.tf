terraform {
  backend "gcs" {
    bucket = "tf-state-test"
	prefix = "deployment"
  }
}

module "network" {
  source = "../../core_module/network"
  vpc_name = var.vpc_name
  subnet = var.subnet_name
  ip_cidr_range = var.ip_cidr_range
  region = var.region
}

module "google_vm" {
  source = "../../core_module/instance"
  depends_on = [module.network]
  project = var.project
  zone = var.zone
  instance_name = var.instance_names
  network = module.network.google_network
  subnetwork = module.network.google_subnet
  image = var.image
  tags = var.tags
  machine_type = var.machine_type
  boot_disk_type = var.boot_disk_type
  boot_disk_size = var.boot_disk_size
}

resource "google_compute_instance_group" "google_ig"
  depends_on = [module.google_vm]
  project = var.project
  zone = var.zone
  name = var.ig_name
  instances = module.google_vm.google_instance_id
  named_port {
     name = var.port_name
	 port = var.port_number
  }
}

module http_lb {
  depends_on = [google_compute_instance_group.google_ig]
  source = "../../core_module/lb"
  project = var.project
  region = var.region
  subnetwork = module.network.google_subnet
  forward_rule_name = format("%s-%s", var.lb_name, "fwd")
  backend_service = google_compute_instance_group.google_ig.selflink
  hosturl = "$(var.lb_name).$(var.domain_name)"
  path_matcher = var.lb_name
  path_rule = var.path_rule
  url_map = var.lb_name
  target_proxy = format("%s-%s", var.lb_name, "proxy")
  frontend_port = var.frontend_port
  frontend_protocol = var.frontend_protocol
  dns_project = var.dns_project
  dns_name = "$(var.lb_name).$(var.domain_name)"
  dns_type = "A"
  managed_zone = var.dns_managed_zone
  dns_ttl = "60"
  dns_cname = "$(var.lb_cname).$(var.domain_name)"
  cname_type = "CNAME"
  rrdatas = ["$(var.lb_name).$(var.domain_name)"]
  cname_ttl = "300"
  zone = var.zone
}

module "google_vm" {
  source = "../../core_module/instance"
  depends_on = [module.network]
  project = var.project
  zone = var.zone
  instance_name = var.backendinstance_names
  network = module.network.google_network
  subnetwork = module.network.google_subnet
  image = var.image
  tags = var.tags
  machine_type = var.machine_type
  boot_disk_type = var.boot_disk_type
  boot_disk_size = var.boot_disk_size
}

module "db_vm"
  source = "../../core_module/database"
  depends_on = [module.network]
  project = var.project
  zone = var.zone
  db_name = var.dbvm_name
  db_version = var.db_version
  network = module.network.google_network
}

resource "google_sql_database" "database"
  depends_on = [module.db_vm]
  name = var.db_name
  instance = module.db_vm.name
}

resource "google_sql_user" "users"
  name = var.db_user
  instance = module.db_vm.name
  password = var.pass ("can be in encrypted format")
}