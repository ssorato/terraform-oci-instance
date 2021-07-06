output "vcn_id" {
  description = "id of vcn that is created"
  value = module.vcn.vcn_id
}

output "public-subnet-name" {
  value = oci_core_subnet.vcn-public-subnet.display_name
}

output "public-subnet-OCID" {
  value = oci_core_subnet.vcn-public-subnet.id
}

output "private-subnet-name" {
  value = oci_core_subnet.vcn-private-subnet.display_name
}

output "private-subnet-OCID" {
  value = oci_core_subnet.vcn-private-subnet.id
}

output "ad" {
  value = lookup(data.oci_identity_availability_domains.ads.availability_domains[0],"name")
}

output "instances_private_ips" {
  value = [oci_core_instance.instances.*.private_ip]
}

output "instances_public_ips" {
  value = [oci_core_instance.instances.*.public_ip]
}

output "instances_dispaly_name" {
  value = [oci_core_instance.instances.*.display_name]
}
