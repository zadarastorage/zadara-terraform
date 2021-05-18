variable "accesskey" {
  default = "your access key"
}
variable "secretkey" {
  default = "your secret key"
}
variable "zcloud_ip" {
  default = "Zadara compute URL"
}
variable "quantity-worker" {
  default = 2
}

variable "managername" {
  default = "rke2-master"
}
variable "workername" {
  default = "rke2-worker-"
}
variable "keyname" {
  default = "your keyname"
}
variable "instance" {
  default = "z4.large"
}
variable "ami" {
    default = "your ami ID starts with ami-"
}
variable "vpc" {
  default = "your VPC ID starts with vpc-"
}
variable "subnet" {
  default = "your Subnet ID starts with subnet-"
}
variable "domainname" {
  default = "zadara.com"
}
