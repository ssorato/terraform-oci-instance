module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "2.2.0"

  # general oci parameters
  compartment_id  = var.tenancy_ocid
  label_prefix    = var.lab_name
  tags            = merge(
    {
      "Name" = "${var.lab_name}-vcn"
    },
    var.common_tag
  )

  # Virtual Cloud Network
  vcn_cidr                 = var.vcn_cidr
  vcn_dns_label            = substr("${var.lab_name}vcndns", 0, 15)
  vcn_name                 = "${var.lab_name}-vcn"
  internet_gateway_enabled = true
}

