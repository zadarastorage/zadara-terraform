variable "accesskey" {
  default = "your key"
}
variable "secretkey" {
  default = "your key"
}
variable "zcloud_ip" {
  default = "url of zcompute cloud"
}
variable "quantity-worker" {
  default = 3
}

variable "managername" {
  default = "k8s-master"
}
variable "workername" {
  default = "k8s-worker-"
}
variable "keyname" {
  default = "your SSH key pair name"
}
variable "instance" {
  default = "z4.large"
}
variable "ami" {
    default = "your Image AMI id"
}
variable "vpc" {
  default = "Your VPC id"
}

variable "subnet" {
  default = "Your Subnet id"
}

variable "domainname" {
  default = "edge.zadara.com"
}
variable "vpsahostname" {
  default = "your VPSA hostname"  
}
variable "vpsatoken" {
  default = "your VPSA Token"
}