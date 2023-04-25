variable "instance_type" {
  description = "type of AWS isntance to use e.g. t2.micro"
  default     = "t3.micro"
}

variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default     = "10.1.0.0/16"
}

variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default     = "10.1.0.0/24"
}

variable "environment_tag" {
  description = "Environment tag"
  default     = "Learn"
}

variable "aws_region" {
  description = "The AWS region to deploy your instance"
  default     = "us-east-2"
}

# Modify the below values

variable "user_name" {
  description = "The user creating this infrastructure"
  default     = "terraform"
}

variable "user_department" {
  description = "The organization the user belongs to: dev, prod, qa"
  default     = "learn"
}
