resource "oci_core_network_security_group" "public_instance_network_security_group" {
	#Required
	compartment_id = oci_identity_compartment.task_compartment.id
	vcn_id = oci_core_vcn.tack_vcn.id

	#Optional
	display_name = "public_instance_network_security_group"
}
resource "oci_core_network_security_group" "private_instance_network_security_group" {
	#Required
	compartment_id = oci_identity_compartment.task_compartment.id
	vcn_id = oci_core_vcn.tack_vcn.id

	#Optional
	display_name = "private_instance_network_security_group"
}
resource "oci_core_network_security_group" "task_network_load_balancer_network_security_group" {
	#Required
	compartment_id = oci_identity_compartment.task_compartment.id
	vcn_id = oci_core_vcn.tack_vcn.id

	#Optional
	display_name = "task_network_load_balancer_network_security_group"
}
resource "oci_core_network_security_group_security_rule" "public_instance_network_security_group_security_rule_out" {
	#Required
	network_security_group_id = oci_core_network_security_group.public_instance_network_security_group.id
    direction = "EGRESS"
    protocol = "all"

    #Optional
    description = "dnf install & adw connect & cli connect"
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    stateless = false
}
resource "oci_core_network_security_group_security_rule" "public_instance_network_security_group_security_rule_ssh_in" {
	#Required
	network_security_group_id = oci_core_network_security_group.public_instance_network_security_group.id
    direction = "INGRESS"
    protocol = "6"

    #Optional
    description = "ssh connect in"
    source = "125.103.97.234/32"
    source_type = "CIDR_BLOCK"
    stateless = false
    tcp_options {

        #Optional
        destination_port_range {
            #Required
            max = 22
            min = 22
        }
    }
}
resource "oci_core_network_security_group_security_rule" "private_instance_network_security_group_security_rule_out" {
	#Required
	network_security_group_id = oci_core_network_security_group.private_instance_network_security_group.id
    direction = "EGRESS"
    protocol = "all"

    #Optional
    description = "dnf install & adw connect & cli connect"
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    stateless = false
}
resource "oci_core_network_security_group_security_rule" "private_instance_network_security_group_security_rule_ssh_in" {
	#Required
	network_security_group_id = oci_core_network_security_group.private_instance_network_security_group.id
    direction = "INGRESS"
    protocol = "6"

    #Optional
    description = "ssh connect in"
    source = "10.1.0.0/24"
    source_type = "CIDR_BLOCK"
    stateless = false
    tcp_options {

        #Optional
        destination_port_range {
            #Required
            max = 22
            min = 22
        }
    }
}
resource "oci_core_network_security_group_security_rule" "private_instance_network_security_group_security_rule_web_in" {
	#Required
	network_security_group_id = oci_core_network_security_group.private_instance_network_security_group.id
    direction = "INGRESS"
    protocol = "6"

    #Optional
    description = "web connect in"
    source = "10.1.0.0/24"
    source_type = "CIDR_BLOCK"
    stateless = false
    tcp_options {

        #Optional
        destination_port_range {
            #Required
            max = 80
            min = 80
        }
    }
}
resource "oci_core_network_security_group_security_rule" "private_instance_network_security_group_security_rule_nlb_ssh_check" {
	#Required
	network_security_group_id = oci_core_network_security_group.private_instance_network_security_group.id
    direction = "INGRESS"
    protocol = "6"

    #Optional
    description = "nlb preserve source ip check ssh"
    source = "125.103.97.234/32"
    source_type = "CIDR_BLOCK"
    stateless = false
    tcp_options {

        #Optional
        destination_port_range {
            #Required
            max = 22
            min = 22
        }
    }
}
resource "oci_core_network_security_group_security_rule" "private_instance_network_security_group_security_rule_nlb_web_check" {
	#Required
	network_security_group_id = oci_core_network_security_group.private_instance_network_security_group.id
    direction = "INGRESS"
    protocol = "6"

    #Optional
    description = "nlb preserve source ip check web"
    source = "125.103.97.234/32"
    source_type = "CIDR_BLOCK"
    stateless = false
    tcp_options {

        #Optional
        destination_port_range {
            #Required
            max = 80
            min = 80
        }
    }
}
resource "oci_core_network_security_group_security_rule" "task_network_load_balancer_network_security_group_security_rule_ssh_in" {
	#Required
	network_security_group_id = oci_core_network_security_group.task_network_load_balancer_network_security_group.id
    direction = "INGRESS"
    protocol = "6"

    #Optional
    description = "nlb ssh connect in"
    source = "125.103.97.234/32"
    source_type = "CIDR_BLOCK"
    stateless = false
    tcp_options {

        #Optional
        destination_port_range {
            #Required
            max = 22
            min = 22
        }
    }
}
resource "oci_core_network_security_group_security_rule" "task_network_load_balancer_network_security_group_security_rule_web_in" {
	#Required
	network_security_group_id = oci_core_network_security_group.task_network_load_balancer_network_security_group.id
    direction = "INGRESS"
    protocol = "6"

    #Optional
    description = "nlb web connect in"
    source = "125.103.97.234/32"
    source_type = "CIDR_BLOCK"
    stateless = false
    tcp_options {

        #Optional
        destination_port_range {
            #Required
            max = 80
            min = 80
        }
    }
}
resource "oci_core_network_security_group_security_rule" "task_network_load_balancer_network_security_group_security_rule_ssh_out" {
	#Required
	network_security_group_id = oci_core_network_security_group.task_network_load_balancer_network_security_group.id
    direction = "EGRESS"
    protocol = "6"

    #Optional
    description = "nlb ssh connect out"
    destination = "10.1.1.0/24"
    destination_type = "CIDR_BLOCK"
    stateless = false
    tcp_options {

        #Optional
		#destination port here!
        destination_port_range {
            #Required
            max = 22
            min = 22
        }
    }
}
resource "oci_core_network_security_group_security_rule" "task_network_load_balancer_network_security_group_security_rule_web_out" {
	#Required
	network_security_group_id = oci_core_network_security_group.task_network_load_balancer_network_security_group.id
    direction = "EGRESS"
    protocol = "6"

    #Optional
    description = "nlb web connect out"
    destination = "10.1.1.0/24"
    destination_type = "CIDR_BLOCK"
    stateless = false
    tcp_options {

        #Optional
		#destination port here!
        destination_port_range {
            #Required
            max = 80
            min = 80
        }
    }
}
