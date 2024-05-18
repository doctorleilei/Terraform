resource "oci_identity_compartment" "task_compartment" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaabf3hx5a6ukjm3ukfzhddy7hdzoa6t4m3wsfikfep25v6dbrwuyya"
  description    = "task_compartment"
  name           = "task_compartment"
}
