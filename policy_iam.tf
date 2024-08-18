locals {
  #dynamic_group_matching_rule = "ALL {resource.type = 'ApiGateway', resource.compartment.id = '${var.compartment_id}' }"
  dynamic_group_matching_rule = "Any {ALL {resource.type = 'ApiGateway', resource.compartment.id = '${var.compartment_id}' }}"
}

resource "oci_identity_dynamic_group" "api_gw_dynamic_grp" {
  compartment_id = var.tenancy_id
  name            = "api-gw-dynamic-grp"
  description     = "Dynamic group for API Gateway management"

  matching_rule = local.dynamic_group_matching_rule
  # [
  #   "ALL {resource.type = \"ApiGateway\", resource.compartment.id = \"${var.compartment_id}\" }"
  # ]
}

# resource "oci_identity_policy" "api_gw_policy" {
#   compartment_id = "ocid1.compartment.oc1..aaaaaaaal2o4vaqyt3kiwvezviozntgck5pp33eihmgdvofrxpl4fiiyztaq"
#   name            = "api-gw-policy"
#   description     = "Policy to allow API Gateway dynamic group to access required resources"

#   statements = [
#     # Allow managing API Gateway resources
#     "allow dynamic-group ${oci_identity_dynamic_group.api_gw_dynamic_grp.name} to manage api-gateway-family in compartment ${oci_identity_dynamic_group.api_gw_dynamic_grp.compartment_id}",

#     # Allow managing Virtual Network resources
#     "allow dynamic-group ${oci_identity_dynamic_group.api_gw_dynamic_grp.name} to manage virtual-network-family in compartment ${oci_identity_dynamic_group.api_gw_dynamic_grp.compartment_id}",

#     # Allow reading Function resources
#     "allow dynamic-group ${oci_identity_dynamic_group.api_gw_dynamic_grp.name} to read functions-family in compartment ${oci_identity_dynamic_group.api_gw_dynamic_grp.compartment_id}",

#     # Allow managing all resources in the compartment
#     "allow dynamic-group ${oci_identity_dynamic_group.api_gw_dynamic_grp.name} to manage all-resources in compartment ${oci_identity_dynamic_group.api_gw_dynamic_grp.compartment_id}"
#   ]
# }
