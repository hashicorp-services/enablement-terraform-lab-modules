variable "region" {
  description = "AWS Cloud Hosting Region"
  default = "us-east-2"
}

variable "prefix" {
  description = "Prefix for the webapp name"
  default     = "academy-webapp"
}

variable "name" {
  description = "Name for webapp"
  default     = <RANDOM_BUCKET_NAME>
}