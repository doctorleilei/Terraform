resource "oci_core_vcn" "tack_vcn" {
  cidr_block     = "10.1.0.0/16"
  compartment_id = oci_identity_compartment.task_compartment.id
  display_name   = "tack_vcn"
}
