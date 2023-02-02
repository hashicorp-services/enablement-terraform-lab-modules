# Terraform Lab Modules

Terraform code and modules used in instruqt labs

This repo is for terraform files that need to be copied on to the host machine for Instruqt labs

Example in the `track_scripts` setup script:

```bash
cd /tmp

git clone https://github.com/hashicorp-services/enablement-terraform-lab-modules.git

mkdir -p /home/terraform

cp -r lab-tfc-private-module-registry/terraform-cloud /home/terraform/terraform-cloud

```
