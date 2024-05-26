resource "oci_core_subnet" "public_subnet" {
  availability_domain       = data.oci_identity_availability_domains.ads.availability_domains[0].name
  cidr_block                = var.public_subnet_cidr_block
  display_name              = "public_subnet"
  security_list_ids         = [oci_core_security_list.public_security_list.id]
  compartment_id            = data.oci_identity_compartment.task_compartment.id
  vcn_id                    = oci_core_vcn.task_vcn.id
  route_table_id            = oci_core_route_table.public_route_table.id
  prohibit_internet_ingress = false
}
resource "oci_core_subnet" "private_subnet" {
  availability_domain       = data.oci_identity_availability_domains.ads.availability_domains[0].name
  cidr_block                = var.private_subnet_cidr_block
  display_name              = "private_subnet"
  security_list_ids         = [oci_core_security_list.private_security_list.id]
  compartment_id            = data.oci_identity_compartment.task_compartment.id
  vcn_id                    = oci_core_vcn.task_vcn.id
  route_table_id            = oci_core_route_table.private_route_table.id
  prohibit_internet_ingress = true
}
