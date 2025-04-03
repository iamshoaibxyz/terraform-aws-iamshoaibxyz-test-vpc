# Output for the VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id 
}

# Output for the IDs of the public subnets
output "public_subnets" {
  description = "The IDs of the public subnets"
  value       = [for subnet in aws_subnet.main : subnet.id if subnet.tags["isPublicSubnet"]]
}

# Output for the IDs of the private subnets
output "private_subnets" {
  description = "The IDs of the private subnets"
  value       = [for subnet in aws_subnet.main : subnet.id if subnet.tags["isPublicSubnet"]]
}
