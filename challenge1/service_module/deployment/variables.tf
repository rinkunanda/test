variable "vpc_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "ip_cidr_range" {
  type = string
}

variable "region" {
  type = string
}

variable "project" {
  type = string
}

variable "instance_names" {
  type = list(string)
}

variable "image" {
  type = string
}

variable "tags" {
  type = list(any)
}

variable "machine_type" {
  type = string
}

variable "boot_disk_type" {
  type = string
}

variable "boot_disk_size" {
  type = string
}

variable "port_name" {
  type = string
}

variable "port_number" {
  type = number
}

variable "lb_name" {
  type = string
}

variable "path_rule" {
  type = string
}

variable "frontend_port" {
  type = number
}

variable "frontend_protocol" {
  type = string
}

variable "dns_zone_name" {
  type = string
}

variable "backendinstance_names" {
  type = string
}

variable "dbvm_names" {
  type = string
}

variable "db_version" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}