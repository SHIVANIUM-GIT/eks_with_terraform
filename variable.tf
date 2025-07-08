variable "name" {
  description = "project name "
}
variable "region" {
  description = "region for the AWS"
}

variable "cidr_block" {
  description = "cidr block for Ip "
}

variable "instance_type" {
  description = "machine power "
  type        = string
}

variable "pub_subnet" {
  description = "subnet for te eks"
  type        = list(string)
}

variable "pri_subnet" {
  description = "subnet for te eks"
  type        = list(string)
}

variable "ami_type" {
  description = "subnet for te eks"
}

variable "instance_ami" {
  description = "ami for the instance"
  type        = string

}