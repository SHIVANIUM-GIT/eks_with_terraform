variable "name" {
  description = "name of the vpc"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
  description = "this cidr block"
}

variable "pub_subnet" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] 
}

variable "pri_subnet" {
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
