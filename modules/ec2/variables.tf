variable "public_key_path" {
  description = "path to the key file (.pem) for the instance"
  type   = string
}

variable "vpc_security_group_ids" {
  description = "security group id"
}

variable "subnet_id" {
  description = "subnet id"
}