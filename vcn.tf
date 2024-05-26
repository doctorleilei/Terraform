resource "oci_core_vcn" "task_vcn" {
  cidr_block     = var.vcn_cidr_block
  compartment_id = data.oci_identity_compartment.task_compartment.id
  display_name   = "task_vcn"
}
