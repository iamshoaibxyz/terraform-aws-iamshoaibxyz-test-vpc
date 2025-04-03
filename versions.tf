terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.30"
    }
  }
}

# AWS provider configuration for the 'ap-southeast-1' region
provider "aws" {
  region = "ap-southeast-1" 
}
