# Data block to fetch details of the API Gateway
# data "oci_apigateway_gateway" "test_gateway" {
#     gateway_id = "ocid1.apigateway.oc1.iad.amaaaaaaz4fdncaafnetzfsah2if27tmqz44cuo6fmo77wjdqhcych5g76oq"
# }

# resource "oci_apigateway_gateway" "APIGateway" {
#   compartment_id = "ocid1.compartment.oc1..aaaaaaaal2o4vaqyt3kiwvezviozntgck5pp33eihmgdvofrxpl4fiiyztaq"
#   endpoint_type  = "PUBLIC"
#   subnet_id      = "ocid1.subnet.oc1.iad.aaaaaaaaek43v3qrcr2aycpdbav5ufe3zq32trulojazand42qdzi4iejd7q"
#   display_name   = "APIGatewayTerraform"
# }



# #Output block to display the gateway details
# output "gateway_details" {
#     value = oci_apigateway_gateway.APIGateway
# }
