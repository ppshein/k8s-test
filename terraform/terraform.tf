terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  backend "s3" {
    region         = "ap-southeast-1"
    role_arn       = "[ROLE]"
    bucket         = "my-task-devops-tfstate-ap"
    key            = "my-task.tfstate"
    dynamodb_table = "my-task-devops-tfstate-ap-lock"
    encrypt        = true
  }
}
