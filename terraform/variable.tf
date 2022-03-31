variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "provider_role" {
  type = string
}

variable "business_unit" {
  type        = string
  description = "The name of the business unit."
}

variable "project" {
  type        = string
  description = "The name of the project."
}

variable "environment" {
  type        = string
  description = "The name of the environment."
}

variable "database" {
  description = "Database credentials to connect"
  type = object({
    host     = string
    name     = string
    user     = string
    password = string
    port     = string
  })
}

variable "application" {
  description = "Application information"
  type = object({
    host = string
    port = string
  })
  default = {
    host = "127.0.0.1"
    port = "3000"
  }
}
