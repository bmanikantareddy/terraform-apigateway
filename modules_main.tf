module "vcn" {
  source = "./modules/vcn"
  compartment_id = var.compartment_id  
  create_new_vcn = var.create_new_vcn
  vcn_cidr       = var.vcn_cidr
  vcn_name       = var.vcn_name
  vcn_id         = var.vcn_id
}

resource "oci_apigateway_gateway" "api_gateway" {
  compartment_id = var.compartment_id
  display_name   = var.api_gateway_name
  endpoint_type  = "PUBLIC"
  subnet_id      = var.create_new_vcn ? module.vcn.public_subnet_id : var.public_subnet_id

  depends_on = [module.vcn]
}

#Output block to display the gateway details
output "gateway_details" {
    value = oci_apigateway_gateway.api_gateway
}
