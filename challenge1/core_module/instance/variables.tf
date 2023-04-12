variable "project" {
  type = string
}

variable "zone" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "tags" {
  type = list(any)
}

variable "metadata" {
  type = map(string)
  default = {}
}

variable "metadata_startup_script" {
  type = ""
}

variable "image" {
  type = string
}

variable "boot_disk_size" {
  type = string
}

variable "boot_disk_type" {
  type = string
}

variable "subnetwork" {
  type = string
}