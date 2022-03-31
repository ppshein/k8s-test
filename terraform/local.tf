locals {
  common_tags = {
    "BusinessUnit" = var.business_unit,
    "Environment"  = var.environment,
    "Project"      = var.project,
    "ManagedBy"    = "Terraform"
  }
}
