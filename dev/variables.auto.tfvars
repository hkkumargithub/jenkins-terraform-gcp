project        = "infra-svc-sop-mysql"
instance_name  = "dev-vm-instance-fifth"
machine_type   = "e2-micro"
project_id     = "infra-svc-sop-mysql"
zone           = "asia-south1-b"
network        = "vpc-11"
subnetwork     = "subnet-11"
region         = "asia-south1"
vm_name        = "dev-vm-instance-fifth"
svc_account_id = "jenkins-vm-sa@infra-svc-sop-mysql.iam.gserviceaccount.com"
network_interface = [{
  nic_subnetwork         = "subnet-11",
  nic_subnetwork_project = "infra-svc-sop-mysql",
  nic_subnetwork_region  = "asia-south1",
  nic0_network_ip        = null,
  nic_access_config      = []
}]