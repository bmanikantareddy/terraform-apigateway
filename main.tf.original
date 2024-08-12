# module "vcn" {
#   source = "./modules/vcn"
#   compartment_id = var.compartment_id  
#   create_new_vcn = var.create_new_vcn
#   vcn_cidr       = var.vcn_cidr
#   vcn_name       = var.vcn_name
#   vcn_id         = var.vcn_id
# }
variable "deployment_path_prefix" {
  default = "/v2"
}

variable "deployment_specification_routes_backend_type" {
  default = "HTTP_BACKEND"
}

variable "deployment_specification_routes_backend_url" {
  default = "https://api.weather.gov"
}

variable "deployment_specification_routes_methods" {
  default = ["GET"]
}

variable "deployment_specification_routes_path" {
  default = "/hello"
}
variable "deployment_specification_routes_path1" {
  default = "/hello1"
}


resource "oci_apigateway_gateway" "api_gateway" {
  compartment_id = var.compartment_id
  display_name   = var.api_gateway_name
  endpoint_type  = "PUBLIC"
  # subnet_id      = var.create_new_vcn ? module.vcn.public_subnet_id : var.public_subnet_id
  subnet_id      = var.public_subnet_id

  # depends_on = [module.vcn]
}

#Output block to display the gateway details
output "gateway_details" {
    value = oci_apigateway_gateway.api_gateway
}


resource "oci_apigateway_deployment" "apigw_deployment" {
    compartment_id = var.compartment_id
    gateway_id = oci_apigateway_gateway.api_gateway.id
    path_prefix = "/v1"
    display_name = "deployment1"

    specification {
      logging_policies {
        access_log {
                is_enabled = true
            }
        execution_log {
                is_enabled = true
                log_level  = "INFO"
            }
      }

    routes {
      path    = "/hello"
      methods = ["GET"]
      backend {
        type = "STOCK_RESPONSE_BACKEND"
        status = 200
        headers {
          name  = "Content-Type"
          value = "text/html"
        }
        body = <<-EOT
        <!DOCTYPE html>
        <html lang="en">
        <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Welcome to My Homepage</title>
          <style>
              body {
                  font-family: Arial, sans-serif;
                  margin: 0;
                  padding: 0;
                  display: flex;
                  flex-direction: column;
                  align-items: center;
                  justify-content: center;
                  height: 100vh;
                  background: linear-gradient(135deg, #71b7e6, #9b59b6);
                  color: #fff;
              }
              header {
                  width: 100%;
                  padding: 20px;
                  text-align: center;
                  background-color: rgba(0, 0, 0, 0.2);
                  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
              }
              header h1 {
                  margin: 0;
                  font-size: 2.5em;
              }
              main {
                  text-align: center;
                  padding: 20px;
              }
              main h2 {
                  font-size: 2em;
                  margin: 10px 0;
              }
              main p {
                  font-size: 1.2em;
              }
              footer {
                  width: 100%;
                  padding: 10px;
                  text-align: center;
                  background-color: rgba(0, 0, 0, 0.2);
                  position: absolute;
                  bottom: 0;
                  box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.2);
              }
              footer p {
                  margin: 0;
                  font-size: 0.9em;
              }
          </style>
        </head>
        <body>
          <header>
              <h1>Welcome to My Homepage</h1>
          </header>
          <main>
              <h2>Hello, World!</h2>
              <p>This is a simple and beautiful homepage created with HTML and CSS. Feel free to customize it!</p>
          </main>
          <footer>
              <p>&copy; 2024 My Homepage. All rights reserved.</p>
          </footer>
        </body>
        </html>
        EOT

      }
    }
  }
}


resource "oci_apigateway_deployment" "test_deployment" {
  #Required
  compartment_id = var.compartment_id
  gateway_id     = oci_apigateway_gateway.api_gateway.id
  path_prefix    = var.deployment_path_prefix

  specification {
    request_policies {
      authentication {
        type                        = "JWT_AUTHENTICATION"
        token_header                = "Authorization"
        token_auth_scheme           = "Bearer"
        is_anonymous_access_allowed = "false"
        issuers                     = ["https://identity.oraclecloud.com/"]
        audiences                   = ["${oci_apigateway_gateway.api_gateway.hostname}"]
        max_clock_skew_in_seconds   = "10"

        public_keys {
          is_ssl_verify_disabled = false
          type = "STATIC_KEYS"
          keys {
            alg = "RS256"
            e = "AQAB"
            format = "JSON_WEB_KEY"
            key = ""
            key_ops = []
            kid = "SIGNING_KEY"
            kty = "RSA"
            n = "sXTvafoBh22bXk492Lp-OOaPRdcQJx3MtdOytgoBjgEOMQXT_nKoSISgxMF0MoEIZqrqMdiuycrK4sXgVc2cMmDZRG0Nsucze2x9hPJ8N-YDa6dPON9xU0nrtGf49E4BT1fdRt8c2zQHS_25K-JaZlhrWuy3wAbczUFTzqsvxPYs4ku704gXrPKH-gg1PUI6zYs4dtIoPLzKCDywNDcjBsFV5eLwpDuEnlQ8mnmJt8RmsddBd4tNPTBQXKfHJisIYqjT4qhmTpI4e1LdkEs5dl2Pr2OxpB--ZDE7owaR7sOtbD4mMgeqP7qLP4eaCIKz6WA4mWOlm-evTvVfjcOVew"
            use = "sig"
          }
          # max_cache_duration_in_hours = "10"
          # uri                         = "https://oracle.com/jwks.json"
        }
      }

      # cors {
      #   allowed_origins = ["*"]
      #   allowed_methods = ["GET"]
      # }

      # rate_limiting {
      #   rate_in_requests_per_second = "10"
      #   rate_key                    = "CLIENT_IP"
      # }
      usage_plans {
        #Required
        token_locations = ["request.headers[client-id]"]
      }
    }
    routes {
      #Required
      backend {
        #Required
        type = var.deployment_specification_routes_backend_type
        url  = var.deployment_specification_routes_backend_url
      }
      path = var.deployment_specification_routes_path
      methods = var.deployment_specification_routes_methods
    }
    routes {
      #Required
      backend {
        #Required
        type = var.deployment_specification_routes_backend_type
        url  = var.deployment_specification_routes_backend_url
      }
      path = var.deployment_specification_routes_path1
      methods = var.deployment_specification_routes_methods
    }
  }
}


resource "oci_apigateway_usage_plan" "test_usage_plan" {
  #Required
  compartment_id = var.compartment_id
  entitlements {
    #Required
    name = "usagePlanEntitlementsTF"

    #Optional
    description = "usage plan entitlements created with terraform"
    quota {
      #Required
      operation_on_breach = "REJECT"
      reset_policy        = "CALENDAR"
      unit                = "MINUTE"
      value               = 10
    }
    rate_limit {
      #Required
      unit  = "SECOND"
      value = 10
    }
    targets {
      #Required
      deployment_id = oci_apigateway_deployment.test_deployment.id
    }
  }

  #Optional
  display_name  = "usage_plan_test_tf"
}