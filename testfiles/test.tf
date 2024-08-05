data "oci_apigateway_gateway" "test_gateway" {
    #Required
    gateway_id = "ocid1.apigateway.oc1.iad.amaaaaaaz4fdncaafnetzfsah2if27tmqz44cuo6fmo77wjdqhcych5g76oq"
}

data "oci_apigateway_deployment" "test_deployment" {
    #Required
    deployment_id = "ocid1.apideployment.oc1.iad.amaaaaaaz4fdncaahqpfezktvoup4sbx6iwsatay6kz2pmsxfsx37sjpnpgq"
}