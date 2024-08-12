variable "compartment_id" {
  description = "The compartment OCID"
  type        = string
}

# this defined_tags and Freeform_tags will apply for all the objectes created with this file.
variable "defined_tags" {
  type    = map(string)
  default = {}
  description = "Defined tags"
}

variable "freeform_tags" {
  type    = map(string)
  default = {}
  description = "Freeform tags"
}

variable "gateway" {
  type = list(object({
    id                         = number
    endpoint_type              = string
    subnet_id                  = string
    certificate_id             = optional(number)
    defined_tags               = optional(map(string))
    display_name               = optional(string)
    freeform_tags              = optional(map(string))
    network_security_group_ids = optional(list(string))
    ca_bundles = optional(list(object({
      type                     = string
      ca_bundle_id             = optional(string)
      certificate_authority_id = optional(string)
    })), [])
    response_cache_details = optional(list(object({
      type                                 = string
      authentication_secret_id             = optional(string)
      authentication_secret_version_number = optional(string)
      connect_timeout_in_ms                = optional(number)
      is_ssl_enabled                       = optional(bool)
      is_ssl_verify_disabled               = optional(number)
      read_timeout_in_ms                   = optional(number)
      send_timeout_in_ms                   = optional(number)
      servers = optional(list(object({
        host = optional(string)
        port = optional(number)
      })), [])
    })), [])
  }))
  default = []
  description = <<EOF
  This resouces provision the OCI API gateway for OAL GEN LLMA 
EOF
}