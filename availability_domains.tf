data "oci_identity_availability_domains" "ads" {
  compartment_id = data.oci_identity_compartment.task_compartment.id
}
