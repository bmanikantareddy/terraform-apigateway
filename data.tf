# data "oci_apigateway_gateway" "this" {
#   count      = length(var.gateway_id) > 0 ? 1 : 0
#   gateway_id = var.gateway_id
# }
