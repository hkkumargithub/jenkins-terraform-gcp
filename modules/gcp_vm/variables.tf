variable "instance_name" {
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