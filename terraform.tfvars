compartment_id = "ocid1.compartment.oc1..aaaaaaaal2o4vaqyt3kiwvezviozntgck5pp33eihmgdvofrxpl4fiiyztaq"
public_subnet_id="ocid1.subnet.oc1.iad.aaaaaaaaek43v3qrcr2aycpdbav5ufe3zq32trulojazand42qdzi4iejd7q"

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
    network_security_group_ids = [
      "nsg-abcdefgh",
      "nsg-ijklmnop"
    ]
  }
]
