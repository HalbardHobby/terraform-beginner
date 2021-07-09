variable "vpc_id" {
  description = "Id for the VPC containing the subnet"
  type        = string
}

variable "cidr_block" {
  type = string
}

variable "security_group_id" {
  type = string
}