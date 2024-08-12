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

##############
# Example Values for variables defined in variable.tf

# Example values
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