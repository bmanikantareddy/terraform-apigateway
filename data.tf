data "oci_apigateway_gateway" "this" {
  count      = var.gateway_id ? 1 : 0
  gateway_id = var.gateway_id
}
