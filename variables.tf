# VPC configuration input variable (CIDR and Name)
variable "vpc_config" {
  description = "To get the CIDR and name of the VPC from the user"
  type = object({
    cidr = string
    name = string 
  })
}

# Subnet configuration input variable (CIDR, Availability Zone, Public Flag)
variable "subnet_config" {
  type = map(object({
    cidr_block = string
    az = string
    public = optional(bool, false)
  }))
  description = "Get the CIDR and availability zone of the subnet from the user"
  
  validation {
    condition = alltrue([for config in var.subnet_config : can(cidrnetmask(config.cidr_block))])
    error_message = "Invalid CIDR block"
  }
}
