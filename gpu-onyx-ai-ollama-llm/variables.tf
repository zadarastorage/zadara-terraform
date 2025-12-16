variable "accesskey" {
  default = "<your access key here>"
}
variable "secretkey" {
  default = "<your secret key here>"
}
variable "zcloud_url" {
  default = "compute-lc-us-east-04.zadara.com"
}
variable "quantity_server" {
  default = 1
}
variable "servername" {
  default = "Demo-GPU-Server"
}
variable "keyname" {
  default = "<your key name here>"
}
variable "instance" {
  default = "GPU_L4.4xlarge" # L4: GPU_L4.4xlarge or L40S: GPU_L40S.4xlarge
}
variable "ami" {
    default = "ami-d21ff96f82204bf89db8a0759cc92bb8" # Ubuntu 24.04
}
variable "vpc" {
  default = "<your vpc id here>" # starting vpc-
}
variable "subnet" {
  default = "<your subnet id here>" # starting subnet-
}
