resource "oci_core_route_table" "public_route_table" {
  compartment_id = data.oci_identity_compartment.task_compartment.id
  vcn_id         = oci_core_vcn.task_vcn.id
  display_name   = "public_route_table"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.task_internet_gateway.id
  }
}
resource "oci_core_route_table" "private_route_table" {
  compartment_id = data.oci_identity_compartment.task_compartment.id
  vcn_id         = oci_core_vcn.task_vcn.id
  display_name   = "private_route_table"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.task_nat_gateway.id
  }
}
