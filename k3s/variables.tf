variable "accesskey" {
  default = ""
}
variable "secretkey" {
  default = ""
}
variable "zcloud_ip" {
  default = "compute-il-interoplab-01.zadara.com"
}
variable "quantity-worker" {
  default = 2
}
variable "managername" {
  default = "k3s-master"
}
variable "workername" {
  default = "k3s-worker-"
}
variable "keyname" {
  default = ""
}
variable "instance" {
  default = "z4.large"
}
variable "ami" {
    default = ""
}
variable "vpc" {
  default = ""
}
variable "subnet" {
  default = ""
}
variable "domainname" {
  default = "edge.zadara.com"
}
