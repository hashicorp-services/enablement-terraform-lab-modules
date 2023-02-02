# Terraform Collaboration Private Registry Lab

Terraform code which deploys an s3 webapp for use in the  HashiCorp Academy Terraform Collaboration lab. This module is used to demonstrate TFC/TFE module publishing workflow into the [Private Module Registry](https://www.terraform.io/docs/cloud/registry/index.html).

The example module deploys an s3 webapp with an index.html that can be visited for inspection. It is a simple collection of Terraform resources that are grouped into a module.

## Usage
```hcl
module "webapp" {
  source  = "app.terraform.io..."
  version = "x.x.x"
}

output "website_endpoint" {
  value = module.webapp.endpoint
}

```
