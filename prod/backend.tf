terraform {
  backend "gcs" {
    bucket = "bkt-cs-as1-terraform-state"
    prefix = "pip-terraform/prod/state"
  }
}