resource "oci_core_nat_gateway" "task_nat_gateway" {
  compartment_id = data.oci_identity_compartment.task_compartment.id
  display_name   = "task_nat_gateway"
  vcn_id         = oci_core_vcn.task_vcn.id
}
output "nat_gateway_nat_ip" {
  value = oci_core_nat_gateway.task_nat_gateway.nat_ip
}