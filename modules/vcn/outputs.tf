output "vcn_id" {
  value = oci_core_vcn.vcn[0].id
}

output "public_subnet_id" {
  value = oci_core_subnet.public_subnet[0].id
}

output "private_subnet_id" {
  value = oci_core_subnet.private_subnet[0].id
}
