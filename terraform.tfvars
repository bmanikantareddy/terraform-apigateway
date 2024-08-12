compartment_id = "ocid1.compartment.oc1..aaaaaaaal2o4vaqyt3kiwvezviozntgck5pp33eihmgdvofrxpl4fiiyztaq"

# Gate object containing details to create OCI API gate way
gateway = [
  {
    id                        = 123456789
    endpoint_type             = "PUBLIC"
    subnet_id                 = "ocid1.subnet.oc1.iad.aaaaaaaaek43v3qrcr2aycpdbav5ufe3zq32trulojazand42qdzi4iejd7q"
    defined_tags              = { }
    display_name              = "oal_api_gateway"
    freeform_tags             = {
      "team" = "oal_devops"
    }
    # network_security_group_ids = [
    #   "nsg-abcdefgh",
    #   "nsg-ijklmnop"
    # ]
  }
]

deployment = [
  {
    id            = 1
    gateway_id    = 123456789
    path_prefix   = "/api/v1"
    display_name  = "first_deployment"
    freeform_tags = {
      "environment" = "prod"
      "team"        = "ola_devops"
    }
    defined_tags  = {}
    specification = [
      {
        logging_policies = [
          {
            access_log = [
              {
                is_enabled = true
              }
            ]
            execution_log = [
              {
                is_enabled = true
                log_level  = "INFO"
              }
            ]
          }
        ]
        request_policies = [
          {
            authentication = [
              {
                type                        = "JWT_AUTHENTICATION"
                # audiences                   = ["example.com"]
                is_anonymous_access_allowed = false
                issuers                     = ["https://identity.oraclecloud.com/"]
                max_clock_skew_in_seconds   = 30
                parameters                  = {}
                token_auth_scheme           = "Bearer"
                token_header                = "Authorization"
                public_keys = [
                  {
                    type                        = "STATIC_KEYS"
                    is_ssl_verify_disabled      = false
                    max_cache_duration_in_hours = 0
                    keys = [
                      {
                        alg     = "RS256"
                        e       = "AQAB"
                        format  = "JSON_WEB_KEY"
                        kid     = "SIGNING_KEY"
                        kty     = "RSA"
                        n       = "sXTvafoBh22bXk492Lp-OOaPRdcQJx3MtdOytgoBjgEOMQXT_nKoSISgxMF0MoEIZqrqMdiuycrK4sXgVc2cMmDZRG0Nsucze2x9hPJ8N-YDa6dPON9xU0nrtGf49E4BT1fdRt8c2zQHS_25K-JaZlhrWuy3wAbczUFTzqsvxPYs4ku704gXrPKH-gg1PUI6zYs4dtIoPLzKCDywNDcjBsFV5eLwpDuEnlQ8mnmJt8RmsddBd4tNPTBQXKfHJisIYqjT4qhmTpI4e1LdkEs5dl2Pr2OxpB--ZDE7owaR7sOtbD4mMgeqP7qLP4eaCIKz6WA4mWOlm-evTvVfjcOVew"
                        use     = "sig"
                        #key_ops = ""
                      }
                    ]
                  }
                ]
                validation_failure_policy = [ ]
                validation_policy =  [ ]
              }
            ]
            # cors = [
            #   {
            #     allowed_origins              = ["*"]
            #     allowed_headers              = ["Content-Type"]
            #     allowed_methods              = ["GET", "POST"]
            #     exposed_headers              = ["X-Custom-Header"]
            #     is_allow_credentials_enabled = true
            #     max_age_in_seconds           = 3600
            #   }
            # ]
            # rate_limiting = [
            #   {
            #     rate_in_requests_per_second = 10
            #     rate_key                    = "client_ip"
            #   }
            # ]
            # usage_plans = [
            #   {
            #     token_locations = ["header"]
            #   }
            # ]
          }
        ]
        routes = [ 
          # route1  
          {
            path    = "/users"
            methods = ["GET"]
            backend = [
              {
                type                       = "HTTP_BACKEND"
                url                        = "http://129.159.105.110/users"
                is_ssl_verify_disabled     = false
                headers = []
              }
            ]
            logging_policies = [
              {
                access_log = [
                  {
                    is_enabled = true
                  }
                ]
                execution_log = [
                  {
                    is_enabled = true
                    log_level  = "INFO"
                  }
                ]
              }
            ]
          }#,
          # # route2  
          # {
          #   path    = "/users/{userid}"
          #   methods = ["GET"]
          #   backend = [
          #     {
          #       type                       = "HTTP"
          #       url                        = "http://129.159.105.110/users/$${request.path[userid]}"
          #       is_ssl_verify_disabled     = false
          #       headers = []
          #     }
          #   ]
          #   logging_policies = [
          #     {
          #       access_log = [
          #         {
          #           is_enabled = true
          #         }
          #       ]
          #       execution_log = [
          #         {
          #           is_enabled = true
          #           log_level  = "DEBUG"
          #         }
          #       ]
          #     }
          #   ]
          # }
        ]
      }
    ]
  }
]

##############
# Example Values for variables defined in variable.tf

# Example values for gateway 
# gateway = [
#   {
#     id                        = 123456789
#     endpoint_type             = "PUBLIC"
#     subnet_id                 = "subnet-abcdefgh"
#     certificate_id            = 987654321
#     defined_tags              = {
#       "env" = "production"
#     }
#     display_name              = "My API Gateway"
#     freeform_tags             = {
#       "team" = "devops"
#     }
#     network_security_group_ids = [
#       "nsg-abcdefgh",
#       "nsg-ijklmnop"
#     ]
#     ca_bundles = [
#       {
#         type                     = "CA_CERT"
#         ca_bundle_id             = "ca-bundle-123"
#         certificate_authority_id = "ca-authority-456"
#       }
#     ]
#     response_cache_details = [
#       {
#         type                                 = "CACHE"
#         authentication_secret_id             = "auth-secret-789"
#         authentication_secret_version_number = "v1"
#         connect_timeout_in_ms                = 3000
#         is_ssl_enabled                       = true
#         is_ssl_verify_disabled               = 0
#         read_timeout_in_ms                   = 5000
#         send_timeout_in_ms                   = 5000
#         servers = [
#           {
#             host = "cache-server-1"
#             port = 6379
#           },
#           {
#             host = "cache-server-2"
#             port = 6379
#           }
#         ]
#       }
#     ]
#   }
# ]

##############################
# Example values for deployment for the above gateway.
# deployment = [
#   {
#     id            = 1
#     gateway_id    = 1001
#     path_prefix   = "/api/v1"
#     display_name  = "Sample Deployment"
#     freeform_tags = {
#       "environment" = "dev"
#       "team"        = "backend"
#     }
#     defined_tags  = {
#       "department" = "engineering"
#     }
#     specification = [
#       {
#         logging_policies = [
#           {
#             access_log = [
#               {
#                 is_enabled = true
#               }
#             ]
#             execution_log = [
#               {
#                 is_enabled = true
#                 log_level  = "INFO"
#               }
#             ]
#           }
#         ]
#         request_policies = [
#           {
#             authentication = [
#               {
#                 type                        = "OAuth2"
#                 audiences                   = ["example.com"]
#                 cache_key                   = ["client_id"]
#                 function_id                 = "func123"
#                 is_anonymous_access_allowed = false
#                 issuers                     = ["issuer1"]
#                 max_clock_skew_in_seconds   = 300
#                 parameters                  = {
#                   "param1" = "value1"
#                 }
#                 token_auth_scheme           = "Bearer"
#                 token_header                = "Authorization"
#                 token_query_param           = "access_token"
#                 public_keys = [
#                   {
#                     type                        = "RSA"
#                     is_ssl_verify_disabled      = false
#                     max_cache_duration_in_hours = 24
#                     uri                         = "https://example.com/keys"
#                     keys = [
#                       {
#                         format  = "PEM"
#                         alg     = "RS256"
#                         key     = "base64encodedkey"
#                       }
#                     ]
#                   }
#                 ]
#                 validation_failure_policy = [
#                   {
#                     type                        = "Redirect"
#                     fallback_redirect_path      = "/error"
#                     response_code               = "302"
#                     response_message            = "Authentication Failed"
#                   }
#                 ]
#                 validation_policy = [
#                   {
#                     type                        = "Token"
#                     is_ssl_verify_disabled      = false
#                     max_cache_duration_in_hours = 12
#                     keys = [
#                       {
#                         format  = "PEM"
#                         alg     = "RS256"
#                         key     = "base64encodedkey"
#                       }
#                     ]
#                   }
#                 ]
#               }
#             ]
#             cors = [
#               {
#                 allowed_origins              = ["*"]
#                 allowed_headers              = ["Content-Type"]
#                 allowed_methods              = ["GET", "POST"]
#                 exposed_headers              = ["X-Custom-Header"]
#                 is_allow_credentials_enabled = true
#                 max_age_in_seconds           = 3600
#               }
#             ]
#             rate_limiting = [
#               {
#                 rate_in_requests_per_second = 10
#                 rate_key                    = "client_ip"
#               }
#             ]
#             usage_plans = [
#               {
#                 token_locations = ["header"]
#               }
#             ]
#           }
#         ]
#         routes = [
#           {
#             path    = "/service"
#             methods = ["GET", "POST"]
#             backend = [
#               {
#                 type                       = "HTTP"
#                 url                        = "https://api.example.com/service"
#                 is_ssl_verify_disabled     = false
#                 headers = [
#                   {
#                     name  = "X-Api-Key"
#                     value = "api_key_value"
#                   }
#                 ]
#               }
#             ]
#             logging_policies = [
#               {
#                 access_log = [
#                   {
#                     is_enabled = true
#                   }
#                 ]
#                 execution_log = [
#                   {
#                     is_enabled = true
#                     log_level  = "DEBUG"
#                   }
#                 ]
#               }
#             ]
#             request_policies = [
#               {
#                 cors = [
#                   {
#                     allowed_origins              = ["https://example.com"]
#                     allowed_headers              = ["Authorization"]
#                     allowed_methods              = ["GET"]
#                     exposed_headers              = ["X-Requested-With"]
#                     is_allow_credentials_enabled = true
#                     max_age_in_seconds           = 3600
#                   }
#                 ]
#               }
#             ]
#             response_policies = [
#               {
#                 header_transformations = [
#                   {
#                     filter_headers = [
#                       {
#                         type = "REMOVE"
#                         items = [
#                           {
#                             name = "X-Deprecated-Header"
#                           }
#                         ]
#                       }
#                     ]
#                     rename_headers = [
#                       {
#                         items = [
#                           {
#                             from = "X-Old-Header"
#                             to   = "X-New-Header"
#                           }
#                         ]
#                       }
#                     ]
#                     set_headers = [
#                       {
#                         items = [
#                           {
#                             name      = "X-Custom-Header"
#                             values    = ["CustomValue"]
#                             if_exists = "overwrite"
#                           }
#                         ]
#                       }
#                     ]
#                   }
#                 ]
#               }
#             ]
#           }
#         ]
#       }
#     ]
#   }
# ]

