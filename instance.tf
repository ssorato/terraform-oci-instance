data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

resource "oci_core_instance" "instances" {
  count               = var.number_of_instances
  availability_domain = lookup(data.oci_identity_availability_domains.ads.availability_domains[0],"name")
  compartment_id      = var.tenancy_ocid
  display_name        = var.name_of_instances[count.index]
  shape               = var.shape_instance[count.index]

  create_vnic_details {
    subnet_id        = oci_core_subnet.vcn-public-subnet.id
    display_name     = "primaryvnic"
    assign_public_ip = true
    hostname_label   = var.name_of_instances[count.index]
  }

  source_details {
    source_type             = "image"
    source_id               = var.instance_image_id
    boot_volume_size_in_gbs = "50" # Boot volume should be greater than or equal to 50GB
  }

  metadata = {
    ssh_authorized_keys = file(var.public_ssh_key)
  }

  freeform_tags = merge(
    {
      "Name" = var.name_of_instances[count.index]
      var.extra_tag_key[count.index] = var.extra_tag_value[count.index]
    },
    var.common_tag
  )

}

resource "oci_core_volume" "extra-volumes" {
  count               = var.number_of_instances
  availability_domain = lookup(data.oci_identity_availability_domains.ads.availability_domains[0],"name")
  compartment_id      = var.tenancy_ocid

  display_name        = "${var.name_of_instances[count.index]}-extravol"
  size_in_gbs         = "50" # It should be between 50 GB and 32768 GB
  
  freeform_tags = merge(
    {
      "Name" = "${var.name_of_instances[count.index]}-extravol"
    },
    var.common_tag
  )
}

resource "oci_core_volume_attachment" "volume_attachment" {
    count           = var.number_of_instances
    attachment_type = "paravirtualized"
    instance_id     = element(oci_core_instance.instances.*.id, count.index)
    volume_id       = element(oci_core_volume.extra-volumes.*.id, count.index) 
    device          = "/dev/oracleoci/oraclevdb"
}
