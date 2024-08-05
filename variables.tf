variable "compartment_id" {
  description = "The compartment OCID"
  type        = string
}

variable "create_new_vcn" {
  description = "Whether to create a new VCN or use an existing one"
  type        = bool
  default     = true
}

variable "vcn_cidr" {
  description = "The CIDR block for the VCN"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vcn_name" {
  description = "The name of the VCN"
  type        = string
  default     = "example-vcn"
}

variable "vcn_id" {
  description = "The OCID of the existing VCN"
  type        = string
  default     = ""
}

variable "api_gateway_name" {
  description = "The name of the API Gateway"
  type        = string
  default     = "example-api-gateway"
}
variable "public_subnet_id" {
  description = "provide public_subnet_id if create_new_vcn is false"
  type        = string
  default     = ""
}
