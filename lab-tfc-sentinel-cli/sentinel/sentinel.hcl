# Declaring location for modules defining re-usable functions
module "tfplan-functions" {
    source = "common-functions/tfplan-functions/tfplan-functions.sentinel"
}

module "tfstate-functions" {
    source = "common-functions/tfstate-functions/tfstate-functions.sentinel"
}

module "tfconfig-functions" {
    source = "common-functions/tfconfig-functions/tfconfig-functions.sentinel"
}

module "tfrun-functions" {
    source = "common-functions/tfrun-functions/tfrun-functions.sentinel"
}

# Setting enformcement levels for policies through root level sentinel.hcl file
policy "prohibited-resources" {
    source = "./prohibited-resources.sentinel"
    enforcement_level = "advisory"
}

policy "require-all-modules-have-version-constraint" {
    source = "./require-all-modules-have-version-constraint.sentinel"
    enforcement_level = "advisory"
}

policy "require-all-resources-from-pmr" {
    source = "./require-all-resources-from-pmr.sentinel"
    enforcement_level = "advisory"
}