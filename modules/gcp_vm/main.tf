resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = var.network
    subnetwork = var.subnetwork
    access_config {
      // Ephemeral IP
    }
  }
}

variable "vm_name" {
  description = "The name of the VM instance"
  type        = string
}

variable "machine_type" {
  description = "The machine type to use for the VM"
  type        = string
}

variable "zone" {
  description = "The zone where the VM will be deployed"
  type        = string
}

variable "image" {
  description = "The image to use for the VM"
  type        = string
}

variable "network" {
  description = "The network to attach to the VM"
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork to attach to the VM"
  type        = string
}
