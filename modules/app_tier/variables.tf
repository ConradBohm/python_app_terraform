variable "vpc_id" {
  description = "The vpc id of which the app is launched"
}

variable "gateway_id" {
  description = "The gateway id to connect the subnet to the internet"
}

variable "my_name" {
  type = string
  default = "Eng48-conrad-bohm-app"
}

variable "ami_id" {
  type = string
  default = "ami-0d8e5cfe85e85b81b"
}
