variable "instance_name" {
  type        = string
  description = "zone"
  default     = "dev-vm-instance"
}

variable "project_id" {
  description = "The GCP project"
  type        = string
}

variable "network" {
  description = "The VPC network to be used"
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork to be used"
  type        = string
}

variable "region" {
  description = "GCP region to be selected"
  type        = string
}

variable "image" {
  description = "The image to use for the VM"
  type        = string
  default     = "ubuntu-2004-focal-v20240614"
}

variable "svc_account_id" {
  description = "The service account attached to the VM"
  type        = string
  default     = "jenkins-vm-sa@infra-svc-sop-mysql.iam.gserviceaccount.com"
}

variable "network_interface" {
  type = list(object({
    nic_subnetwork         = string
    nic_subnetwork_project = string
    nic_subnetwork_region  = string
    # nic_access_config = list(object({
    #   nic_nat_ip       = string
    #   nic_network_tier = string
    # }))
  }))
}