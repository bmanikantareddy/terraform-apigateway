# # data "oci_apigateway_gateway" "test_gateway" {
# #     #Required
# #     gateway_id = "ocid1.apigateway.oc1.iad.amaaaaaaz4fdncaafnetzfsah2if27tmqz44cuo6fmo77wjdqhcych5g76oq"
# # }

# # data "oci_apigateway_deployment" "test_deployment" {
# #     #Required
# #     #deployment_id = "ocid1.apideployment.oc1.iad.amaaaaaaz4fdncaahqpfezktvoup4sbx6iwsatay6kz2pmsxfsx37sjpnpgq"
# #     deployment_id = "ocid1.apideployment.oc1.iad.amaaaaaaz4fdncaahev6wnwbes732mqanky63fdzjqtcvthuo7xvf7ajk3da"
# # }

# # output "oci_apigateway_deployment_output" {
# #     value = data.oci_apigateway_deployment.test_deployment
# # }


# data "oci_apigateway_usage_plan" "test_usage_plan" {
#     #Required
#     usage_plan_id = "ocid1.apigatewayusageplan.oc1.iad.amaaaaaan3n6yvya6t4lufyyjov2usl3bnhrpwppo7nq3c3mmwnhnwgzmnxq"
# }


# output "oci_apigateway_usage_plan_output" {
#     value = data.oci_apigateway_usage_plan.test_usage_plan
# }


# # data "oci_apigateway_usage_plan" "usage_plan" {

# #     value="ocid1.apigatewayusageplan.oc1.iad.amaaaaaan3n6yvya6t4lufyyjov2usl3bnhrpwppo7nq3c3mmwnhnwgzmnxq"
# # }

# # output "oci_apigateway_usage_plan_output" {

# #     value= data.oci_apigateway_usage_plan.usage_plan
# # }


# data "oci_identity_dynamic_groups" "test_dynamic_groups" {
#     compartment_id = "ocid1.tenancy.oc1..aaaaaaaaaq37gwcnkgq7wsgyydh3tbhg2xvtcmt56mxkmt35qvqaohb7vrhq"
#     # value="ocid1.dynamicgroup.oc1..aaaaaaaatgvyvchjtd6vnpet2hzrgsamag777py3vumjeynaclhi5l7vg5hq"
# }



data "oci_apigateway_gateway" "test_gateway" {
    gateway_id = "ocid1.apigateway.oc1.iad.amaaaaaa6n4kpkya43f77bq7pcyxi636fjzk6sf2ufl5pdf56lcpvwpq52ha"
}

# output "oci_apigateway_gateway_output" {

#     value = data.oci_apigateway_gateway.test_gateway
# }


output "gateway_id" {
  value = data.oci_apigateway_gateway.test_gateway.gateway_id
}
output "display_name" {
  value = data.oci_apigateway_gateway.test_gateway.display_name
}