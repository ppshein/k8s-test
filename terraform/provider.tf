provider "aws" {
  region = var.region
  assume_role {
    role_arn = var.provider_role
  }
}

data "aws_iam_account_alias" "current" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
