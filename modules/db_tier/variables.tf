variable "vpc_id" {
  description = "The vpc id of which the app is launched"
}

variable "my_name" {
  type = string
  default = "Eng48-conrad-bohm-db"
}

variable "app_security_group_id" {
  description = "secutity group cidr"
}

variable "ami_id" {
  type = string
  default = "ami-051f9bffabaa7f4b5"
}
