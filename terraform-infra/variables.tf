variable "vpc_cidr_block" {
    description = "VPC Cidr Block"
    type = string
}

variable "vpc_name" {
    description = "VPC Name"
    type = string
}

variable "app_subnet_cidr" {
    description = "CIDR Block for App Subnet"
    type = string
}

variable "app_subnet_az" {
    description = "Availability Zone for App Subnet"
    type = string
}

variable "app_subnet_name" {
    description = "App Subnet Name"
    type = string
}

variable "private_subnet_cidr" {
    description = "Cidr Block for Private Subnet"
    type = string
}

variable "private_subnet_az" {
    description = "Availability Zone for Private Subnet"
    type = string
}

variable "private_subnet_name" {
    description = " Name of the Private Subnet"
    type = string
}

variable "igw_name" {
    description = "Internet Gateway"
    type = string
}

variable "public_rt_name" {
    description = "Route Table name"
    type = string
}

variable "app_port" {
    description = "App Port"
    type = string
}

variable "app_ami" {
    description = "AMI ID For App Instance"
    type = string
}

#variable "app_port" {
#    description = ""
#    type = string
#}