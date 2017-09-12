variable "name" {
  description = "The name of the VPC"
  type        = "string"
}

variable "cidr" {
  description = "The CIDR of the VPC"
  type        = "string"
}

variable "prod-private-primary-1a" {
  description = "prod-private-primary-1a"
  default     = ""
}

variable "prod-private-secondary-1b" {
  description = "prod-private-secondary-1b"
  default     = ""
}

variable "prod-public-primary-1a" {
  description = "prod-public-primary-1a"
  default     = ""
}

variable "prod-public-secondary-1b" {
  description = "prod-public-secondary-1b"
  default     = ""
}

variable "corp-private-primary-1a" {
  description = "corp-private-primary-1a"
  default     = ""
}

variable "corp-private-secondary-1b" {
  description = "corp-private-secondary-1b"
  default     = ""
}

variable "corp-public-hubzuprod-1a" {
  description = "corp-public-hubzuprod-1a"
  default     = ""
}

variable "uat-private-primary-1a" {
  description = "uat-private-primary-1a"
  default     = ""
}

variable "uat-private-secondary-1b" {
  description = "uat-private-secondary-1b"
  default     = ""
}

variable "uat-public-primary-1a" {
  description = "uat-public-primary-1a"
  default     = ""
}

variable "uat-public-secondary-1b" {
  description = "uat-public-secondary-1b"
  default     = ""
}

variable "az-1a" {
  description = "az-1a"
  default     = "us-east-1a"
}

variable "az-1b" {
  description = "az-1b"
  default     = "us-east-1b"
}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = false
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = false
}
