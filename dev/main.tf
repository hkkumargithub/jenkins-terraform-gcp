module "gcp_vm" {
  source        = "../modules/gcp_vm"
  instance_name = var.instance_name
  machine_type  = var.machine_type
  zone          = var.zone
  image         = var.image
  network       = var.network
  subnetwork    = var.subnetwork
}

provider "google" {
  project = var.project
  region  = var.region
}

variable "instance_name" {}
variable "machine_type" {}
variable "zone" {}
variable "project" {}
