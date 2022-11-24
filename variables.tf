variable "aws_account_id" {
  description  = "ID of AWS account for the VPC being connected"
  type         = string
  sensitive    = true
}

variable "aws_region" {
  description  = "AWS region of the VPC being connected"
  type         = string
}

variable "billing_tags" {
  description  = "Billing tags associated with connector"
  type         = list(string)
  default      = []
}

variable "credential" {
  description  = "Name of credential to use for onboarding VPC"
  type         = string
}

variable "custom_routing" {
  description  = "Controls if custom routing is used from cloud network to CXP"
  type         = bool
  default      = false
}

variable "custom_tgw" {
  description  = "Controls if specific subnets are used for linked availability zones"
  type         = bool
  default      = false
}

variable "cxp" {
  description  = "CXP to provision connector in"
  type         = string
}

variable "direct_inter_vpc" {
  description = "Enable direct inter-vpc communication"
  type        = bool
  default     = false
}

variable "failover_cxps" {
  description = "Enable direct inter-vpc communication"
  type        = list(string)
  default     = []
}

variable "route_table_id" {
  description  = "ID of VPC default route table"
  type         = string
  default      = ""
}

variable "enabled" {
  description  = "Status of connector"
  type         = bool
  default      = true
}

variable "group" {
  description  = "Group to associate with connector"
  type         = string
  default      = ""
}

variable "name" {
  description  = "Name of connector"
  type         = string
}

variable "onboard_subnet" {
  description = "Controls if subnet gets onboarded in place of entire VPC CIDR block"
  type        = bool
  default     = false
}

variable "vpc_route_table" {
  description = "Custom options used to influence routing from cloud network to CXP"

  type = list(object({
    option          = optional(string)
    prefix_lists    = optional(list(string), [])
    route_table_id  = optional(string)
  }))
  default = []
}

variable "segment" {
  description  = "Segment to provision connector in"
  type         = string
}

variable "vpc_subnet" {
  description = "Subnets to onboard in place of entire VPC CIDR block"

  type = list(object({
    subnet_id    = optional(string)
    subnet_cidr  = optional(string)
  }))
  default = []
}

variable "size" {
  description  = "Size of connector"
  type         = string
  default      = "SMALL"
}

variable "tgw_attachment" {
  description = "Subnets to use for linked availability zones"

  type = list(object({
    az         = optional(string)
    subnet_id  = optional(string)
  }))
  default = []
}


variable "vpc_id" {
  description  = "ID of AWS VPC that is being connected"
  type         = string
}

variable "vpc_cidr" {
  description  = "CIDR of AWS VPC that is being connected"
  type         = list(string)
  default      = []
}