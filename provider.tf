provider "aws" {
  region = "us-east-1"
}

provider "oci" {
  tenancy_ocid      = var.tenancy_ocid
  user_ocid         = var.user_ocid
  fingerprint       = var.oci_key_fingerprint
  private_key_path  = var.oci_private_key
  region            = var.oci_region
}
