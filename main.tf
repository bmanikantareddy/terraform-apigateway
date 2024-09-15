# locals {
#   client_tokens = {
#     for_each = var.subscriber.clients
#     value    = uuid()
#   }
# }

resource "oci_apigateway_gateway" "apigateway" {
  compartment_id = var.compartment_id
  endpoint_type  = var.gateway.endpoint_type
  subnet_id      =  var.gateway.subnet_id
  display_name = var.gateway.display_name
}

data "oci_secrets_secretbundle" "oauth_static_key" {
  secret_id = "ocid1.vaultsecret.oc1.iad.amaaaaaa6n4kpkyazyzmp4ylhklsoyidw5qd44kshmf6kzzkc757p6bs3ska"
}

output "secret_value" {
  value = base64decode(data.oci_secrets_secretbundle.oauth_static_key.secret_bundle_content[0].content)
}

resource "oci_apigateway_deployment" "gw_deployment" {
  count          = length(var.deployment) > 0 ? 1 : 0
  compartment_id = var.compartment_id
  gateway_id = oci_apigateway_gateway.apigateway.id 
  path_prefix  = lookup(var.deployment[count.index], "path_prefix")
  display_name = lookup(var.deployment[count.index], "display_name")
  dynamic "specification" {
    for_each = lookup(var.deployment[count.index], "specification", [])
    content {
      dynamic "logging_policies" {
        for_each = lookup(specification.value, "logging_policies", [])
        content {
          dynamic "access_log" {
            for_each = lookup(logging_policies.value, "access_log", [])
            content {
              is_enabled = lookup(access_log.value, "is_enabled", false)
            }
          }
          dynamic "execution_log" {
            for_each = lookup(logging_policies.value, "execution_log", [])
            content {
              is_enabled = lookup(execution_log.value, "is_enabled", false)
              log_level  = lookup(execution_log.value, "log_level", "INFO")
            }
          }
        }
      }
      dynamic "request_policies" {
        for_each = lookup(specification.value, "request_policies",[])
        content {
          dynamic "authentication" {
            for_each = lookup(request_policies.value, "authentication",[])
            #for_each = var.enable_OAuth ? lookup(request_policies.value, "authentication", []) : []
            content {
              type                        = lookup(authentication.value, "type")
              audiences                   = [ oci_apigateway_gateway.apigateway.hostname ]
              cache_key                   = lookup(authentication.value, "cache_key")
              function_id                 = lookup(authentication.value, "function_id")
              is_anonymous_access_allowed = lookup(authentication.value, "is_anonymous_access_allowed")
              issuers                     = lookup(authentication.value, "issuers")
              max_clock_skew_in_seconds   = lookup(authentication.value, "max_clock_skew_in_seconds")
              parameters                  = lookup(authentication.value, "parameters")
              token_auth_scheme           = lookup(authentication.value, "token_auth_scheme")
              token_header                = lookup(authentication.value, "token_header")
              token_query_param           = lookup(authentication.value, "token_query_param")

              dynamic "public_keys" {
                for_each = lookup(authentication.value, "public_keys",[])
                content {
                  type                        = lookup(public_keys.value, "type")
                  is_ssl_verify_disabled      = lookup(public_keys.value, "is_ssl_verify_disabled")
                  max_cache_duration_in_hours = lookup(public_keys.value, "max_cache_duration_in_hours")
                  uri                         = lookup(public_keys.value, "uri")

                  dynamic "keys" {
                    for_each = lookup(public_keys.value, "keys",[])
                    content {
                      format  = lookup(keys.value, "format")
                      alg     = lookup(keys.value, "alg")
                      e       = lookup(keys.value, "e")
                      key     = lookup(keys.value, "key")
                      n       = base64decode(data.oci_secrets_secretbundle.oauth_static_key.secret_bundle_content[0].content) #lookup(keys.value, "n")
                      kid     = lookup(keys.value, "kid")
                      kty     = lookup(keys.value, "kty")
                      use     = lookup(keys.value, "use")
                    }
                  }
                }
              }
            }
          }

          dynamic "usage_plans" {
            for_each = lookup(request_policies.value, "usage_plans", [])
            content {
              token_locations = lookup(usage_plans.value, "token_locations")
            }
          }
        }
      }
      dynamic "routes" {
        for_each = lookup(specification.value, "routes",[])
        content {
          path    = lookup(routes.value, "path")
          methods = lookup(routes.value, "methods")

          dynamic "backend" {
            for_each = lookup(routes.value, "backend",[])
            content {
              type                       = lookup(backend.value, "type")
              allowed_post_logout_uris   = lookup(backend.value, "allowed_post_logout_uris")
              body                       = lookup(backend.value, "body")
              connect_timeout_in_seconds = lookup(backend.value, "connect_timeout_in_seconds")
              function_id                = lookup(backend.value, "function_id")
              is_ssl_verify_disabled     = lookup(backend.value, "is_ssl_verify_disabled")
              post_logout_state          = lookup(backend.value, "post_logout_state")
              read_timeout_in_seconds    = lookup(backend.value, "read_timeout_in_seconds")
              send_timeout_in_seconds    = lookup(backend.value, "send_timeout_in_seconds")
              status                     = lookup(backend.value, "status")
              url                        = lookup(backend.value, "url")
            }
          }
          dynamic "logging_policies" {
            for_each = lookup(routes.value, "logging_policies", [])
            content {
              dynamic "access_log" {
                for_each = lookup(logging_policies.value, "access_log", [])
                content {
                  is_enabled = lookup(access_log.value, "is_enabled")
                }
              }
              dynamic "execution_log" {
                for_each = lookup(logging_policies.value, "execution_log", [])
                content {
                  is_enabled = lookup(execution_log.value, "is_enabled")
                  log_level  = lookup(execution_log.value, "log_level")
                }
              }
            }
          }
        }
      }
    }
  }
}

resource "oci_apigateway_usage_plan" "usageplan" {
  count          = length(var.usage_plan) > 0 ? 1 : 0
  compartment_id = var.compartment_id
  display_name = var.usage_plan.display_name

  entitlements{
    name = var.usage_plan.entitlement.name
    description = var.usage_plan.entitlement.description
    quota {
      operation_on_breach = var.usage_plan.entitlement.quota.operation_on_breach
      reset_policy = var.usage_plan.entitlement.quota.reset_policy
      unit = var.usage_plan.entitlement.quota.unit
      value = var.usage_plan.entitlement.quota.value
    }
    rate_limit {
      unit = var.usage_plan.entitlement.rate_limit.unit
      value = var.usage_plan.entitlement.rate_limit.value
    }
    targets {
      deployment_id = oci_apigateway_deployment.gw_deployment[0].id
    }
  }
}

# resource "oci_apigateway_subscriber" "subscriber" {
#   count          = length(var.subscriber) > 0 ? 1 : 0
#   compartment_id = var.compartment_id
#   usage_plans    = [oci_apigateway_usage_plan.usageplan[0].id]

#   display_name = var.subscriber.display_name
#   dynamic "clients" {
#     for_each = var.subscriber.clients
#     content {
#       name  = lookup(clients.value, "name")
#       token = lookup(clients.value, "token") #uuid() 
#     }
#   }
#   # lifecycle {
#   #   ignore_changes = [
#   #     clients # This ignores changes to the token field across all clients
#   #   ]
#   # }
# }


resource "oci_apigateway_subscriber" "subscriber" {
  count          = length(var.subscriber)
  compartment_id = var.compartment_id
  usage_plans    = [oci_apigateway_usage_plan.usageplan[0].id]

  display_name = lookup(var.subscriber[count.index], "display_name")
  dynamic "clients" {
    for_each = lookup(var.subscriber[count.index], "clients")
    content {
      name  = lookup(clients.value, "name")
      token = base64encode(replace(uuid(), "-", "")) #lookup(clients.value, "token")
    }
  }

  # Add lifecycle block at the resource level
  lifecycle {
    ignore_changes = [
      clients  # Ignore changes to the entire clients block, including the token
    ]
  }
}

# resource "oci_vault_secret" "subscriber_secrets" {
#   # for_each = {
#   #   for subscriber in oci_apigateway_subscriber.subscriber :
#   #     subscriber.display_name => {
#   #       for client in subscriber.clients :
#   #         client.name => client.token
#   #     }
#   # }

#   for_each = {
#     for subscriber in oci_apigateway_subscriber.subscriber :
#     for client in subscriber.clients :
#     "${subscriber.display_name}_${client.name}" => client.token
#   }

#   compartment_id = "ocid1.compartment.oc1.us-san-1.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" # Replace with your compartment ID
#   vault_id        = "ocid1.vault.oc1.iad.bbpjuvrxaacuu.abuwcljrvdp4jh4s2lxsvveijlibdbod4sqdztzuykxt56hjpzenv66loz3a"
#   key_id          = "ocid1.key.oc1.iad.bbpjuvrxaacuu.abuwcljt2alb2uztw33iq3xkbyiqgsjqkeiyhsospr4zqcvck3enqygr3d2q"
#   secret_name = each.key

#   secret_content {
#     content     = base64encode(each.value)
#     content_type = "BASE64"
#   }
# }

# output "api_gateway_output" {
#   value = {
#     tenancy_id = var.tenancy_id
#     compartment = var.compartment_id
#     gateway_id = length(var.gateway_id) > 0 ? data.oci_apigateway_gateway.this[0].id : oci_apigateway_gateway.this[0].id 
#     usage_plan = oci_apigateway_usage_plan.this[0].id
#     subnet_id = oci_apigateway_subscriber.this[0].id
#     clients = oci_apigateway_subscriber.this[0].clients
#   }
# }