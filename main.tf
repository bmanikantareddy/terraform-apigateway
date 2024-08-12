resource "oci_apigateway_gateway" "this" {
  count          = length(var.gateway)
  compartment_id = data.oci_identity_compartment.this.compartment_id
  endpoint_type  = lookup(var.gateway[count.index], "endpoint_type")
  subnet_id      = lookup(var.gateway[count.index], "subnet_id")
  certificate_id = try(
    data.oci_apigateway_certificate.this.certificate_id,
    element(oci_apigateway_certificate.this.*.id, lookup(var.gateway[count.index], "certificate_id"))
  )
  defined_tags = merge(
    var.defined_tags,
    lookup(var.gateway[count.index], "defined_tags")
  )
  display_name = lookup(var.gateway[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.gateway[count.index], "freeform_tags")
  )
  network_security_group_ids = lookup(var.gateway[count.index], "network_security_group_ids")

  dynamic "ca_bundles" {
    for_each = lookup(var.gateway[count.index], "ca_bundles") == null ? [] : ["ca_bundles"]
    content {
      type                     = lookup(ca_bundles.value, "type")
      ca_bundle_id             = lookup(ca_bundles.value, "ca_bundle_id")
      certificate_authority_id = lookup(ca_bundles.value, "certificate_authority_id")
    }
  }

  dynamic "response_cache_details" {
    for_each = lookup(var.gateway[count.index], "response_cache_details") == null ? [] : ["response_cache_details"]
    content {
      type                                 = lookup(response_cache_details.value, "type")
      authentication_secret_id             = lookup(response_cache_details.value, "authentication_secret_id")
      authentication_secret_version_number = lookup(response_cache_details.value, "authentication_secret_version_number")
      connect_timeout_in_ms                = lookup(response_cache_details.value, "connect_timeout_in_ms")
      is_ssl_enabled                       = lookup(response_cache_details.value, "is_ssl_enabled")
      is_ssl_verify_disabled               = lookup(response_cache_details.value, "is_ssl_verify_disabled")
      read_timeout_in_ms                   = lookup(response_cache_details.value, "read_timeout_in_ms")
      send_timeout_in_ms                   = lookup(response_cache_details.value, "send_timeout_in_ms")

      dynamic "servers" {
        for_each = lookup(response_cache_details.value, "servers") == null ? [] : ["servers"]
        content {
          host = lookup(servers.value, "host")
          port = lookup(servers.value, "port")
        }
      }
    }
  }
}