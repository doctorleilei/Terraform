resource "oci_core_internet_gateway" "task_internet_gateway" {
  compartment_id = oci_identity_compartment.task_compartment.id
  display_name   = "task_internet_gateway"
  vcn_id         = oci_core_vcn.tack_vcn.id
}
