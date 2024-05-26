provider "oci" {
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaabf3hx5a6ukjm3ukfzhddy7hdzoa6t4m3wsfikfep25v6dbrwuyya"
  user_ocid = "ocid1.user.oc1..aaaaaaaabfhycvut2yqgqmaldtiqk23kurkdup5qs4khqjjwqtda3cowm44q" 
  private_key_path = var.file_path_oci_api_private_key
  fingerprint = "55:4a:ff:50:ee:9e:1f:82:d5:d2:5f:14:60:cf:46:d4"
  region = "ap-tokyo-1"
}