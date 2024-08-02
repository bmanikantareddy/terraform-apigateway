variable "compartment_id" {
  description = "The compartment OCID"
  type        = string
}

variable "create_new_vcn" {
  description = "Whether to create a new VCN or use an existing one"
  type        = bool
}

variable "vcn_cidr" {
  description = "The CIDR block for the VCN"
  type        = string
}

variable "vcn_name" {
  description = "The name of the VCN"
  type        = string
}

variable "vcn_id" {
  description = "The OCID of the existing VCN"
  type        = string
  default     = ""
}
