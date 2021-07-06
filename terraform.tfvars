lab_name              = "ocilab"

tenancy_ocid          = "ocid1.tenancy.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
user_ocid             = "ocid1.user.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
oci_private_key       = "xxxxx.pem"
oci_key_fingerprint   = "xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx"

oci_region            = "us-ashburn-1"

public_subnet_cidr    = "192.168.230.0/26"
private_subnet_cidr   = "192.168.230.128/26"

number_of_instances     = 3

name_of_instances       = [
    "vm1",
    "vm2",
    "vm3"
]

extra_tag_key           = [
    "lab-host-type",
    "lab-host-type",
    "lab-host-type"
]

extra_tag_value         = [
    "master_vm",
    "worker_vm",
    "worker_vm"
]

shape_instance             = [
    "VM.Standard.E2.1",
    "VM.Standard.E2.1",
    "VM.Standard.E2.1"
]

common_tag      = {
    Terraform = "terraform-oci-instance"
    Environment = "ocilab"
}


