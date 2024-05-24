resource "oci_database_autonomous_database" "task_autonomous_database" {
  #Required
  admin_password = "Zhang19870110"
  compartment_id = oci_identity_compartment.task_compartment.id
  db_name        = "taskAutonomousDatabase"

  #Optional
  db_workload  = "DW"
  display_name = "task_autonomous_database"
  # VCN OCID can't be used
  whitelisted_ips = ["125.103.97.234", oci_core_public_ip.public_instance_reserved_public_ip.ip_address, oci_core_nat_gateway.task_nat_gateway.nat_ip]
  is_free_tier    = true
}
output "autonomous_database_connection_strings" {
  value = oci_database_autonomous_database.task_autonomous_database.connection_strings
}
