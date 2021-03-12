variable "vpc_cidr" {
  description = "cidr block for the vpc"
  type = string
}

variable "subnet_cidr" {
  description = "cidr block for the subnet"
  type = string
}

variable "subnet_availability_zone" {
  description = "availability zones for the subnet"
  type = string
}

# variable "remote_bucket_name" {
#   description = "an s3 bucket name for storing the terraform remote state"
#   type = string
# }
