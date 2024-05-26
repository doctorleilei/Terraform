data "oci_core_public_ip" "public_instance_reserved_public_ip" {
  #Required
  id = var.public_instance_reserved_public_ip_id
}
data "oci_core_public_ip" "task_network_load_balancer_reserved_public_ip" {
  #Required
  id = var.task_network_load_balancer_reserved_public_ip_id
}
output "public_instance_reserved_public_ip" {
  value = data.oci_core_public_ip.public_instance_reserved_public_ip.ip_address
}
output "task_network_load_balancer_reserved_public_ip" {
  value = data.oci_core_public_ip.task_network_load_balancer_reserved_public_ip.ip_address
}
