variable "vpc_cidr" {
  description = "cidr block for the vpc"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "cidr block for the subnet"
  type        = string
  default     = "10.0.2.0/16"
}

variable "subnet_availability_zone" {
  description = "availability zone for the subnet"
  type        = string
  default     = "eu-west-2a"
}

variable "public_key_path" {
  description = "value"
  type        = string
  default     = "~/.ssh/scalac.pub"
}

# variable "remote_bucket_name" {
#   description = "an s3 bucket name for storing the remote state"
#   type   = string
# }
