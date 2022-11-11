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

variable "cxp" {
  description  = "CXP to provision connector in"
  type         = string
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

variable "segment" {
  description  = "Segment to provision connector in"
  type         = string
}

variable "size" {
  description  = "Size of connector"
  type         = string
  default      = "SMALL"
}

variable "vpc_id" {
  description  = "ID of AWS VPC that is being connected"
  type         = string
}

variable "vpc_cidr" {
  description  = "CIDR of AWS VPC that is being connected"
  type         = list(string)
}