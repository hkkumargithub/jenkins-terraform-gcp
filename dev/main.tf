module "gcp_vm" {
  source       = "../modules/gcp_vm"
  vm_name      = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone
  image        = var.image
  network      = var.network
  subnetwork   = var.subnetwork
}

provider "google" {
  project = var.project
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket = "bkt-cs-as1-terraform-state"
    prefix = "pip-terraform/dev/state"
  }
}

variable "vm_name" {}
variable "machine_type" {}
variable "zone" {}
variable "project" {}
