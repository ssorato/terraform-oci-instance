#
# credit: https://stackoverflow.com/questions/54802682/terraform-aws-ec2-ssh
#
data "http" "myip"{
  url = "https://ipv4.icanhazip.com"
}

resource "oci_core_security_list" "public-security-list" {
  #Required
  compartment_id  = var.tenancy_ocid
  vcn_id          = module.vcn.vcn_id
  display_name = "Public subnet security list"

  ingress_security_rules {
    protocol    = "1" # icmp
    source      = var.vcn_cidr
    source_type = "CIDR_BLOCK"
    stateless   = false
    description = "Allow icmp from vcn"

    icmp_options {
        code = -1
        type = 3
    }
  }

  ingress_security_rules {
    protocol    = "1" # icmp
    source      = "${chomp(data.http.myip.body)}/32"
    source_type = "CIDR_BLOCK"
    stateless   = false
    description = "Allow icmp from my public ip"

    icmp_options {
        code = -1
        type = 3
    }
  }


  ingress_security_rules {
    protocol    = "6" # tcp
    source      = var.vcn_cidr
    source_type = "CIDR_BLOCK"
    stateless   = false
    description = "Allow all tcp ports from vcn"
  }

  ingress_security_rules {
    protocol    = "6" # tcp
    source      = "${chomp(data.http.myip.body)}/32"
    source_type = "CIDR_BLOCK"
    stateless   = false
    description = "Allow all tcp ports from my public ip"
  }

  egress_security_rules {
      destination      = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
      protocol         = "all"
      stateless        = false
  }
  
  freeform_tags = merge(
    {
      "Name" = "${var.lab_name}-public-security-list"
    },
    var.common_tag
  )

}


resource "oci_core_security_list" "private-security-list" {
  #Required
  compartment_id  = var.tenancy_ocid
  vcn_id          = module.vcn.vcn_id
  display_name = "Private subnet security list"

  ingress_security_rules {
    protocol    = "1" # icmp
    source      = var.vcn_cidr
    source_type = "CIDR_BLOCK"
    stateless   = false
    description = "Allow icmp from vcn"

    icmp_options {
        code = -1
        type = 3
    }
  }

  ingress_security_rules {
    protocol    = "6" # tcp
    source      = var.vcn_cidr
    source_type = "CIDR_BLOCK"
    stateless   = false
    description = "Allow all tcp ports from vcn"
  }

  egress_security_rules {
      destination      = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
      protocol         = "all"
      stateless        = false
  }

  freeform_tags = merge(
    {
      "Name" = "${var.lab_name}-private-security-list"
    },
    var.common_tag
  )

}