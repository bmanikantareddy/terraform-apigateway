resource "oci_core_vcn" "vcn" {
  count              = var.create_new_vcn ? 1 : 0
  compartment_id     = var.compartment_id
  cidr_block         = var.vcn_cidr
  display_name       = var.vcn_name
  dns_label          = var.vcn_name
  freeform_tags      = {}
  defined_tags       = {}
}

resource "oci_core_subnet" "public_subnet" {
  count            = var.create_new_vcn ? 1 : 0
  compartment_id   = var.compartment_id
  vcn_id           = oci_core_vcn.vcn.id
  cidr_block       = "10.0.1.0/24"
  display_name     = "${var.vcn_name}-public-subnet"
  dns_label        = "publicsubnet"
  security_list_ids = [oci_core_vcn.vcn.default_security_list_id]
  route_table_id    = oci_core_vcn.vcn.default_route_table_id
  dhcp_options_id   = oci_core_vcn.vcn.default_dhcp_options_id
}

resource "oci_core_subnet" "private_subnet" {
  count            = var.create_new_vcn ? 1 : 0
  compartment_id   = var.compartment_id
  vcn_id           = oci_core_vcn.vcn.id
  cidr_block       = "10.0.2.0/24"
  display_name     = "${var.vcn_name}-private-subnet"
  dns_label        = "privatesubnet"
  security_list_ids = [oci_core_vcn.vcn.default_security_list_id]
  route_table_id    = oci_core_vcn.vcn.default_route_table_id
  dhcp_options_id   = oci_core_vcn.vcn.default_dhcp_options_id
}

output "vcn_id" {
  value = oci_core_vcn.vcn.id
}

output "public_subnet_id" {
  value = oci_core_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = oci_core_subnet.private_subnet.id
}
