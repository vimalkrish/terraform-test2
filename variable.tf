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
  default     = []
}

variable "prod-private-secondary-1b" {
  description = "prod-private-secondary-1b"
  default     = []
}

variable "prod-public-primary-1a" {
  description = "prod-public-primary-1a"
  default     = []
}

variable "prod-public-secondary-1b" {
  description = "prod-public-secondary-1b"
  default     = []
}

variable "azs" {
  description = "A list of Availability zones in the region"
  default     = []
}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = false
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = false
}
