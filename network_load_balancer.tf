resource "oci_network_load_balancer_network_load_balancer" "task_network_load_balancer" {
  #Required
  compartment_id             = oci_identity_compartment.task_compartment.id
  display_name               = "task_load_balancer"
  subnet_id                  = oci_core_subnet.public_subnet.id
  is_private                 = false
  network_security_group_ids = [oci_core_network_security_group.nlb_network_security_group.id]
  reserved_ips {
    id = data.oci_core_public_ip.task_network_load_balancer_reserved_public_ip.id
  }
}
resource "oci_network_load_balancer_backend_set" "task_backend_set_ssh" {
  #Required
  health_checker {
    #Required
    protocol = "TCP"
    #Optional
    port = 22
  }
  name                     = "task_backend_set_ssh"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.task_network_load_balancer.id
  policy                   = "FIVE_TUPLE"
}
resource "oci_network_load_balancer_backend" "task_backend_ssh" {
  #Required
  backend_set_name         = oci_network_load_balancer_backend_set.task_backend_set_ssh.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.task_network_load_balancer.id
  port                     = 22
  #Optional
  ip_address = oci_core_instance.private_instance.private_ip
  name       = "task_backend_ssh"
  target_id  = oci_core_instance.private_instance.id
}
resource "oci_network_load_balancer_listener" "task_listener_ssh" {
  #Required
  default_backend_set_name = oci_network_load_balancer_backend_set.task_backend_set_ssh.name
  name                     = "task_listener_ssh"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.task_network_load_balancer.id
  port                     = 22
  protocol                 = "TCP"
}
resource "oci_network_load_balancer_backend_set" "task_backend_set_web" {
  #Required
  health_checker {
    #Required
    protocol = "TCP"
    #Optional
    port = 80
  }
  name                     = "task_backend_set_web"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.task_network_load_balancer.id
  policy                   = "FIVE_TUPLE"
}
resource "oci_network_load_balancer_backend" "task_backend_web" {
  #Required
  backend_set_name         = oci_network_load_balancer_backend_set.task_backend_set_web.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.task_network_load_balancer.id
  port                     = 80
  #Optional
  ip_address = oci_core_instance.private_instance.private_ip
  name       = "task_backend_web"
  target_id  = oci_core_instance.private_instance.id
}
resource "oci_network_load_balancer_listener" "task_listener_web" {
  #Required
  default_backend_set_name = oci_network_load_balancer_backend_set.task_backend_set_web.name
  name                     = "task_listener_web"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.task_network_load_balancer.id
  port                     = 80
  protocol                 = "TCP"
}
output "network_load_balancer_public_ip" {
  value = [for ip_address in oci_network_load_balancer_network_load_balancer.task_network_load_balancer.ip_addresses : ip_address.ip_address if ip_address.is_public][0]
}
