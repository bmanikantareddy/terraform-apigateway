resource "random_string" "client_token" {
  count  = 2 #length(var.subscribers) * length(var.subscribers[0].clients)
  special = false
  upper   = true
  lower   = true
  numeric  = true
  length  = 8  # Specify the length of the token here
}

output "token" {

    value = random_string.client_token[*]
}
