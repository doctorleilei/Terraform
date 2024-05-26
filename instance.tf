resource "oci_core_instance" "public_instance" {
  # Required
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = data.oci_identity_compartment.task_compartment.id
  shape               = var.instance_sharp
  shape_config {
    ocpus         = 1
    memory_in_gbs = 6
  }
  source_details {
    source_type = "image"
    source_id   = var.instance_source_id
  }

  # Optional
  display_name = "public_instance"
  create_vnic_details {
    display_name     = "public_instance_vnic"
    assign_public_ip = true
    subnet_id        = oci_core_subnet.public_subnet.id
    nsg_ids          = [oci_core_network_security_group.public_instance_network_security_group.id]
  }
  metadata = {
    ssh_authorized_keys = file(var.file_path_ssh_authorized_public_key)
    user_data = base64encode(templatefile(
      var.file_path_public_instance_user_data,
      {
        task_autonomous_database_id : oci_database_autonomous_database.task_autonomous_database.id,
        private_instance_id : oci_core_instance.private_instance.id,
        oci_api_config : replace(file(var.file_path_oci_api_config), "\n", "\\n"),
        oci_api_private_key : replace(file(var.file_path_oci_api_private_key), "\n", "\\n"),
        ssh_authorized_private_key : replace(file(var.file_path_ssh_authorized_private_key), "\n", "\\n"),
        reserved_public_ip_id : data.oci_core_public_ip.public_instance_reserved_public_ip.id,
        private_subnet_id : oci_core_subnet.private_subnet.id,
        private_instance_nsg_id : oci_core_network_security_group.private_instance_network_security_group.id
    }))
  }
  preserve_boot_volume = false
}
resource "oci_core_instance" "private_instance" {
  # Required
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = data.oci_identity_compartment.task_compartment.id
  shape               = var.instance_sharp
  shape_config {
    ocpus         = 1
    memory_in_gbs = 6
  }
  source_details {
    source_type = "image"
    source_id   = var.instance_source_id
  }

  # Optional
  display_name = "private_instance"
  create_vnic_details {
    assign_public_ip = false
    subnet_id        = oci_core_subnet.private_subnet.id
    nsg_ids          = [oci_core_network_security_group.private_instance_network_security_group.id]
  }
  metadata = {
    ssh_authorized_keys = file(var.file_path_ssh_authorized_public_key)
    user_data           = filebase64(var.file_path_private_instance_user_data)
  }
  preserve_boot_volume = false
}
# Outputs for compute instance
output "public_instance_public_ip" {
  value = oci_core_instance.public_instance.public_ip
}
output "public_instance_private_ip" {
  value = oci_core_instance.public_instance.private_ip
}
output "private_instance_private_ip" {
  value = oci_core_instance.private_instance.private_ip
}
