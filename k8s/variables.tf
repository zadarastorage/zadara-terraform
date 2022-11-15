variable "accesskey" {
  default = "your access key"
}
variable "secretkey" {
  default = "your secret key"
}
variable "zcloud_ip" {
  default = "your project url"
}
variable "quantity-worker" {
  default = 2
}
variable "managername" {
  default = "k8s-master"
}
variable "workername" {
  default = "k8s-worker-"
}
variable "keyname" {
  default = "your ssh key"
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
  default = "edge.zadara.com"
}
