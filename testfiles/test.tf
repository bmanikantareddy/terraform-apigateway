data "oci_apigateway_gateway" "test_gateway" {
    #Required
    gateway_id = "ocid1.apigateway.oc1.iad.amaaaaaaz4fdncaafnetzfsah2if27tmqz44cuo6fmo77wjdqhcych5g76oq"
}

data "oci_apigateway_deployment" "test_deployment" {
    #Required
    #deployment_id = "ocid1.apideployment.oc1.iad.amaaaaaaz4fdncaahqpfezktvoup4sbx6iwsatay6kz2pmsxfsx37sjpnpgq"
    deployment_id = "ocid1.apideployment.oc1.iad.amaaaaaaz4fdncaahev6wnwbes732mqanky63fdzjqtcvthuo7xvf7ajk3da"
}

output "oci_apigateway_deployment_output" {
    value = data.oci_apigateway_deployment.test_deployment
}


data "oci_apigateway_usage_plan" "test_usage_plan" {
    #Required
    usage_plan_id = "ocid1.apigatewayusageplan.oc1.iad.amaaaaaaz4fdncaaomgflatagjkvuyaywxtgcbauej4tiavst5nyw2i4itvq"
}


output "oci_apigateway_usage_plan_output" {
    value = data.oci_apigateway_usage_plan.test_usage_plan
}