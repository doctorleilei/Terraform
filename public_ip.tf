resource "oci_core_public_ip" "public_instance_reserved_public_ip" {
  #Required
  compartment_id = oci_identity_compartment.task_compartment.id
  lifetime       = "RESERVED"

  #Optional
  display_name = "public_instance_reserved_public_ip"
}
resource "oci_core_public_ip" "task_network_load_balancer_reserved_public_ip" {
  #Required
  compartment_id = oci_identity_compartment.task_compartment.id
  lifetime       = "RESERVED"

  #Optional
  display_name = "task_network_load_balancer_reserved_public_ip"
}
output "public_instance_reserved_public_ip" {
  value = oci_core_public_ip.public_instance_reserved_public_ip.ip_address
}
output "task_network_load_balancer_reserved_public_ip" {
  value = oci_core_public_ip.task_network_load_balancer_reserved_public_ip.ip_address
}
