resource "oci_core_subnet" "vcn-public-subnet"{
  # Required
  compartment_id  = var.tenancy_ocid
  vcn_id          = module.vcn.vcn_id
  cidr_block      = var.public_subnet_cidr
 
  # Optional
  route_table_id    = module.vcn.ig_route_id
  security_list_ids = [oci_core_security_list.public-security-list.id]
  display_name      = "${var.lab_name}-public-subnet"
  dns_label         = "public"

  freeform_tags = merge(
    {
      "Name" = "${var.lab_name}-vcn-public-subnet"
    },
    var.common_tag
  )
}

resource "oci_core_subnet" "vcn-private-subnet"{
  # Required
  compartment_id  = var.tenancy_ocid
  vcn_id          = module.vcn.vcn_id
  cidr_block      = var.private_subnet_cidr
 
  # Optional
  # Caution: For the route table id, use module.vcn.nat_route_id.
  # Do not use module.vcn.nat_gateway_id, because it is the OCID for the gateway and not the route table.
  route_table_id    = module.vcn.nat_route_id
  security_list_ids = [oci_core_security_list.private-security-list.id]
  display_name      = "${var.lab_name}-private-subnet"
  dns_label         = "private"

  freeform_tags = merge(
    {
      "Name" = "${var.lab_name}-vcn-private-subnet"
    },
    var.common_tag
  )

}