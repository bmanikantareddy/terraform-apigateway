module "vcn" {
  source = "./modules/vcn"
  compartment_id = var.compartment_id  
  create_new_vcn = var.create_new_vcn
  vcn_cidr       = var.vcn_cidr
  vcn_name       = var.vcn_name
  vcn_id         = var.vcn_id
}

resource "oci_apigateway_gateway" "api_gateway" {
  compartment_id = var.compartment_id
  display_name   = var.api_gateway_name
  endpoint_type  = "PUBLIC"
  subnet_id      = var.create_new_vcn ? module.vcn.public_subnet_id : var.public_subnet_id

  depends_on = [module.vcn]
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