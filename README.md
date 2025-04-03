# VPC Terraform Module

This module provisions a basic VPC with public and private subnets in AWS.

## Usage

To use this module, specify the VPC configuration and subnet configuration in your root module.

```hcl
module "vpc" {
  source = "./terraform-aws-iamshoaibxyz-test-vpc"
  
  vpc_config = {
    cidr = "10.0.0.0/16"
    name = "my-vpc"
  }
  
  subnet_config = {
    "public" = { az = "ap-southeast-1a", cidr_block = "10.0.0.0/24", public = true }
    "private" = { az = "ap-southeast-1b", cidr_block = "10.0.1.0/24" }
  }
}
```