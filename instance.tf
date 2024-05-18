resource "oci_core_instance" "public_instance" {
  # Required
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.task_compartment.id
  shape               = "VM.Standard.A1.Flex"
  shape_config {
    ocpus         = 1
    memory_in_gbs = 6
  }
  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaaongp2eu5zvioimbvbdh2h7leg7jdn4rmcv2lputdnpfikysou3dq"
  }

  # Optional
  display_name = "public_instance"
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.public_subnet.id
    nsg_ids          = [oci_core_network_security_group.public_network_security_group.id]
  }
  metadata = {
    ssh_authorized_keys = file("E:/OneDrive/LEI/Documents/OCI/homework/.ssh/id_rsa.pub")
    user_data           = base64encode(templatefile("E:/OneDrive/LEI/Documents/OCI/homework/terraform/bash/public-instance.yml", { task_autonomous_database_id : oci_database_autonomous_database.task_autonomous_database.id, private_instance_id : oci_core_instance.private_instance.id, config : replace(file("E:/OneDrive/LEI/Documents/OCI/homework/.oci/config"), "\n", "\\n"), oci_api_key : replace(file("E:/OneDrive/LEI/Documents/OCI/homework/.oci/oci_api_key.pem"), "\n", "\\n"), id_rsa : replace(file("E:/OneDrive/LEI/Documents/OCI/homework/.ssh/id_rsa"), "\n", "\\n"), public_ip_id : data.oci_core_public_ip.public_instance_reserved_public_ip.id }))
  }
  preserve_boot_volume = false
}
resource "oci_core_vnic_attachment" "public_vnic_attachment" {
	#Required
	create_vnic_details {

		#Optional
		assign_public_ip = false
		nsg_ids = [oci_core_network_security_group.private_network_security_group.id]
		subnet_id = oci_core_subnet.private_subnet.id
	}
	instance_id = oci_core_instance.public_instance.id
}
resource "oci_core_instance" "private_instance" {
  # Required
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.task_compartment.id
  shape               = "VM.Standard.A1.Flex"
  shape_config {
    ocpus         = 1
    memory_in_gbs = 6
  }
  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaaongp2eu5zvioimbvbdh2h7leg7jdn4rmcv2lputdnpfikysou3dq"
  }

  # Optional
  display_name = "private_instance"
  create_vnic_details {
    assign_public_ip = false
    subnet_id        = oci_core_subnet.private_subnet.id
    nsg_ids          = [oci_core_network_security_group.private_network_security_group.id]
  }
  metadata = {
    ssh_authorized_keys = file("E:/OneDrive/LEI/Documents/OCI/homework/.ssh/id_rsa.pub")
    user_data           = filebase64("E:/OneDrive/LEI/Documents/OCI/homework/terraform/bash/private-instance.yml")
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
