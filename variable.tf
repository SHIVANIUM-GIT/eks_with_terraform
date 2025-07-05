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
}

variable "pub_subnet" {
  description = "subnet for te eks"

}

variable "pri_subnet" {
  description = "subnet for te eks"

}
