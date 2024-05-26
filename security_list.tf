resource "oci_core_security_list" "public_security_list" {
  #Required
  compartment_id = data.oci_identity_compartment.task_compartment.id
  vcn_id         = oci_core_vcn.task_vcn.id
  display_name   = "public_security_list"
}
resource "oci_core_security_list" "private_security_list" {
  #Required
  compartment_id = data.oci_identity_compartment.task_compartment.id
  vcn_id         = oci_core_vcn.task_vcn.id
  display_name   = "private_security_list"
}
