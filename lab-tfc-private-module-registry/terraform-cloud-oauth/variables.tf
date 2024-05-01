
variable hostname {
  type        = string
  description = "The HCP Terraform/Enterprise hostname to connect to"
  default     = "app.terraform.io"
}

variable "oauth_name" {
  type = string
  default = "academy-github"
}

variable "organization" {
  type = string
  description = "HCP Terraform organization"
}

variable "gh_pat" {
  type = string
  description = "Github Personal Access token"
}
