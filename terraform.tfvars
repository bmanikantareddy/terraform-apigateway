tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaaq37gwcnkgq7wsgyydh3tbhg2xvtcmt56mxkmt35qvqaohb7vrhq"
compartment_id = "ocid1.compartment.oc1..aaaaaaaayp3344wjk7ezaf5s7acep5sxm6q4cdegpu3lyt3dgp7vd5oifr6q"
compartment_name = "oal_api_gateway"

# Gateway object containing details to create OCI API gate way
gateway = {
    endpoint_type             = "PUBLIC"
    subnet_id                 = "ocid1.subnet.oc1.iad.aaaaaaaaoaixgtgoo3sggsfzycct5ys43a72kiaz5n5vl6ob6vcytxt74wyq"
    display_name              = "oal-ai-gateway"
  }

# if you want to use the exisitng API gateway instead of creating New one. Provide the gateway OCID like below
#gateway_id="ocid1.apigateway.oc1.iad.amaaaaaan3n6yvyauxl4bzhisgldofdfi4va6n4ryflwjxkjnuhlekykgiwa"
# deployment Object containing details to create OCI API gateway deployment
deployment = [
  {
    id            = 1
    path_prefix   = "/"
    display_name  = "api-gateway-shared-infra"
    specification = [
      {
        logging_policies = [
          {
            access_log = [
              # {
              #   is_enabled = false
              # }
            ]
            execution_log = [
              {
                is_enabled = false
                //log_level  = "INFO"
              }
            ]
          }
        ]
        request_policies = [
          {
            authentication = [
              # {
              #   type                        = "JWT_AUTHENTICATION"
              #   is_anonymous_access_allowed = false
              #   issuers                     = ["https://identity.oraclecloud.com/"]
              #   max_clock_skew_in_seconds   = 30
              #   parameters                  = {}
              #   token_auth_scheme           = "Bearer"
              #   token_header                = "Authorization"
              #   public_keys = [
              #     {
              #       type                        = "STATIC_KEYS"
              #       is_ssl_verify_disabled      = false
              #       max_cache_duration_in_hours = 0
              #       keys = [
              #         {
              #           alg     = "RS256"
              #           e       = "AQAB"
              #           format  = "JSON_WEB_KEY"
              #           kid     = "SIGNING_KEY"
              #           kty     = "RSA"
              #           n       = "sXTvafoBh22bXk492Lp-OOaPRdcQJx3MtdOytgoBjgEOMQXT_nKoSISgxMF0MoEIZqrqMdiuycrK4sXgVc2cMmDZRG0Nsucze2x9hPJ8N-YDa6dPON9xU0nrtGf49E4BT1fdRt8c2zQHS_25K-JaZlhrWuy3wAbczUFTzqsvxPYs4ku704gXrPKH-gg1PUI6zYs4dtIoPLzKCDywNDcjBsFV5eLwpDuEnlQ8mnmJt8RmsddBd4tNPTBQXKfHJisIYqjT4qhmTpI4e1LdkEs5dl2Pr2OxpB--ZDE7owaR7sOtbD4mMgeqP7qLP4eaCIKz6WA4mWOlm-evTvVfjcOVew"
              #           use     = "sig"
              #         }
              #       ]
              #     }
              #   ]
              # }
            ]
            usage_plans = [
              {
                token_locations = ["request.headers[client-id]"]
              }
            ]
          }
        ]
        routes = [ 
          # route1  
          {
            path    = "/generate/gpu"
            methods = ["POST"]
            backend = [
              {
                type                       = "HTTP_BACKEND"
                url                        = "http://10.3.232.112:80/generate"
                is_ssl_verify_disabled     = false
              }
            ]
            logging_policies = [
              # {
              #   access_log = [
              #     {
              #       is_enabled = false
              #     }
              #   ]
              #   execution_log = [
              #     {
              #       is_enabled = false
              #       log_level  = "INFO"
              #     }
              #   ]
              # }
            ]
          },
          # route2  
          {
            path    = "/generate/cpu"
            methods = ["POST"]
            backend = [
              {
                type                       = "HTTP_BACKEND"
                url                        = "http://10.3.232.112:8001/completion"
                is_ssl_verify_disabled     = false
              }
            ]
            logging_policies = [
              # {
              #   access_log = [
              #     {
              #       is_enabled = true
              #     }
              #   ]
              #   execution_log = [
              #     {
              #       is_enabled = true
              #       log_level  = "INFO"
              #     }
              #   ]
              # }
            ]
          },
          # route3
          {
            path    = "/agents/tgi/v1/chat/completions"
            methods = ["POST"]
            backend = [
              {
                type                       = "HTTP_BACKEND"
                url                        = "http://10.3.232.112:80/v1/chat/completions"
                is_ssl_verify_disabled     = false
                headers = []
              }
            ]
            logging_policies = [
              # {
              #   access_log = [
              #     {
              #       is_enabled = true
              #     }
              #   ]
              #   execution_log = [
              #     {
              #       is_enabled = true
              #       log_level  = "INFO"
              #     }
              #   ]
              # }
            ]
          },
          {
            path    = "/agents/vllm/v1/chat/completions"
            methods = ["POST"]
            backend = [
              {
                type                       = "HTTP_BACKEND"
                url                        = "http://10.3.232.33:80/v1/chat/completions"
                is_ssl_verify_disabled     = false
              }
            ]
            logging_policies = [
              # {
              #   access_log = [
              #     {
              #       is_enabled = true
              #     }
              #   ]
              #   execution_log = [
              #     {
              #       is_enabled = true
              #       log_level  = "INFO"
              #     }
              #   ]
              # }
            ]
          },
          {
            path    = "/agents/cpu/v1/chat/completions"
            methods = ["POST"]
            backend = [
              {
                type                       = "HTTP_BACKEND"
                url                        = "http://10.3.232.112:8001/v1/chat/completions"
                is_ssl_verify_disabled     = false
              }
            ]
            logging_policies = [
              # {
              #   access_log = [
              #     {
              #       is_enabled = true
              #     }
              #   ]
              #   execution_log = [
              #     {
              #       is_enabled = true
              #       log_level  = "INFO"
              #     }
              #   ]
              # }
            ]
          },
          {
            path    = "/generate/vllm"
            methods = ["POST"]
            backend = [
              {
                type                       = "HTTP_BACKEND"
                url                        = "http://10.3.232.33:80/v1/completions"
                is_ssl_verify_disabled     = false
              }
            ]
            logging_policies = [
              # {
              #   access_log = [
              #     {
              #       is_enabled = true
              #     }
              #   ]
              #   execution_log = [
              #     {
              #       is_enabled = true
              #       log_level  = "INFO"
              #     }
              #   ]
              # }
            ]
          }
        ]
      }
    ]
  }
]

## 
# subscriber = {
#     display_name = "AIOPS"
#     clients = [
#       {
#         name  = "aiops_team"
#         # token = "abc123"
#       },
#       # {
#       #   name  = "ClientB"

#       #   # token = "def456"
#       # },
#       # {
#       #   name  = "ClientC"
#       #   # token = "def456"
#       # }
#     ]
#   }


usage_plan =   {
    display_name = "aiops_team"
    entitlement = {
        name        = "aiops"
        description = "aiops team plan"
        quota = {
            operation_on_breach = "REJECT"
            reset_policy        = "CALENDAR"
            unit                = "HOUR"
            value               = 5000
          }
        rate_limit = {
            unit  = "SECOND"
            value = 5
          }
      }
  }


subscriber = [
  {
    id = 1
    display_name = "oTech"
    clients = [
      {
        name  = "oTech"
        token = "Q0v23abPwVyKnDlxgk5YnssrRonyktzHx2zsfY-BcRA"
      }
    ]
  },
  {
    id = 2
    display_name = "agent49"
    clients = [
      {
        name  = "agent49"
        token = "CKxh6AvPsYvWNrh4Qy5U0hbDpxQ4yBWdGSEYzzXGeQg"
      }
    ]
  },
  {
    id = 3
    display_name = "biops_team"
    clients = [
      {
        name  = "biops"
        token = "b6CCuqfyG8SQRPvqET8PsCxxBLVQMHlhcA901eLImtM"
      }
    ]
  },
  {
    id = 4
    display_name = "contractassist"
    clients = [
      {
        name  = "contractassist"
        token = "Uan8ECewIzhG4eZmzn7pGPRrL5TbGTKA6QBKEPa9bXA"
      }
    ]
  },

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

## exmaple values for subscription and usage plan for OCI API gateway

# subscriber = [
#   {
#     id = 1
#     usage_plans = ["BasicPlan", "PremiumPlan"]
#     defined_tags = {
#       Environment = "Production"
#     }
#     display_name = "Subscriber1"
#     freeform_tags = {
#       Owner = "TeamA"
#     }
#     clients = [
#       {
#         name  = "ClientA"
#         token = "abc123"
#       },
#       {
#         name  = "ClientB"
#         token = "def456"
#       }
#     ]
#   },
#   {
#     id = 2
#     usage_plans = ["StandardPlan"]
#     defined_tags = {
#       Environment = "Staging"
#     }
#     display_name = "Subscriber2"
#     freeform_tags = {
#       Owner = "TeamB"
#     }
#     clients = [
#       {
#         name  = "ClientC"
#         token = "ghi789"
#       }
#     ]
#   }
# ]

# usage_plans = [
#   {
#     id = 101
#     defined_tags = {
#       Department = "Finance"
#     }
#     display_name = "BasicPlan"
#     freeform_tags = {
#       Owner = "TeamA"
#     }
#     entitlements = [
#       {
#         name        = "Entitlement1"
#         description = "Basic plan entitlement"
#         quota = [
#           {
#             operation_on_breach = "Notify"
#             reset_policy        = "Daily"
#             unit                = "Requests"
#             value               = 1000
#           }
#         ]
#         rate_limit = [
#           {
#             unit  = "Requests"
#             value = 10
#           }
#         ]
#         targets = [
#           {
#             deployment_id = 201
#           }
#         ]
#       }
#     ]
#   },
#   {
#     id = 102
#     defined_tags = {
#       Department = "IT"
#     }
#     display_name = "PremiumPlan"
#     freeform_tags = {
#       Owner = "TeamB"
#     }
#     entitlements = [
#       {
#         name        = "Entitlement2"
#         description = "Premium plan entitlement"
#         quota = [
#           {
#             operation_on_breach = "Throttle"
#             reset_policy        = "Hourly"
#             unit                = "Requests"
#             value               = 5000
#           }
#         ]
#         rate_limit = [
#           {
#             unit  = "Requests"
#             value = 50
#           }
#         ]
#         targets = [
#           {
#             deployment_id = 202
#           }
#         ]
#       }
#     ]
#   }
# ]
