variable "accesskey" {
  type = string  // Your access Key
}
variable "secretkey" {
  type = string  // Your secret Key
}
variable "zcloud_ip" {
  type = string  // FQDN or IP of Zadara Compute cloud (eg, compute-example-01.zadara.com)
}
variable "quantity-server" {
  default = 2
}
variable "servername" {
  default = "server-"
}
variable "keyname" {
  type = string  // Name of Key Pair to be used for VM
}
variable "instance" {
  default = "z4.large"
}
variable "ami" {
  type = string  // Image ID, starts with ami-
}
variable "vpc" {
  type = string  // VPC ID, starts with vpc-
}
variable "subnet" {
  type = string  // Subnet ID, starts with subnet-
}
