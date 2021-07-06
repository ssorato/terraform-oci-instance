variable "lab_name" {
  type = string
  description = "Lab name"
}

variable "tenancy_ocid" {
  type = string
  description = "Tenancy OCID"
}

variable "user_ocid" {
  type = string
  description = "User OCID"
}

variable "oci_key_fingerprint" {
  type = string
  description = "OCI key fingerprint"
}

variable "oci_private_key" {
  type = string
  description = "OCI private key path"
}

variable "oci_region" {
  type = string
  description = "OCI region"
}

variable "vcn_cidr" {
  type = string
  description = "Virtual Cloud Network CIDR"
  default = "192.168.230.0/24"
}

variable "public_subnet_cidr" {
  type = string
  description = "Public subnet"
}

variable "private_subnet_cidr" {
  type = string
  description = "Private subnet"
}

variable "number_of_instances" {
  type = number
  description = "Number of instances"
  default = 1
}

variable "name_of_instances" {
  type = list(string)
  description = "Name of instances"
  default = ["sample-vm"]
}

variable "extra_tag_key" {
  type = list(string)
  description = "Key tag about instances"
  default = [""]
}

variable "extra_tag_value" {
  type = list(string)
  description = "Value tag about instances"
  default = [""]
}

variable "shape_instance" {
  type = list(string)
  description = "Shape of instances"
  default = ["VM.Standard.E2.1.Micro"]
}

# https://docs.oracle.com/en-us/iaas/images/image/a453cbfd-b1e0-4a59-b27d-637e3c56b192/
# Canonical-Ubuntu-20.04-2020.10.14-0
variable "instance_image_id" {
  type = string
  description = "Image of instances"
  default = "ocid1.image.oc1.iad.aaaaaaaanoalk3fhpbocojo3wma5e3xrye5yestrujevos44ol42a2lqzhba"
}

variable "public_ssh_key" {
  type = string
  description = "The public ssh key"
  default = "id_rsa.pub"
}

variable "common_tag" {
  type = map(string)
  description = "Common resource tags"
}
