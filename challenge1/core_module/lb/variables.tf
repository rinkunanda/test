variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "url_map" {
  type = string
}

variable "target_proxy" {
  type = string
}

variable "forward_rule_name" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "frontend_port" {
  type = string
}

variable "frontend_protocol" {
  type = string
}

variable "hosturl" {
  type = string
}

variable "path_matcher" {
  type = string
}

variable "path_rule" {
  type = list
}

variable "global_access" {
  type = bool
}

variable "backend_service" {
  type = string
}

variable "dns_project" {
  type = string
}

variable "dns_name" {
  type = string
}

variable "dns_type" {
  type = string
}

variable "managed_zone" {
  type = string
}

variable "dns_ttl" {
  type = string
}

variable "cname_type" {
  type = string
}

variable "dns_cname" {
  type = string
}

variable "cname_ttl" {
  type = string
}

variable "rrdatas" {
  type = list(any)
}