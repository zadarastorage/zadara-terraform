// determine the external IP of the system running OpenTofu/Terraform
data "http" "myip" {
  url = "https://ip.rights.ninja/ip"
}

resource "aws_security_group" "allow_all" {
  vpc_id      = var.vpc
  name        = "allow_all"
  description = "Allow all outbout, allow only me inbound"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"] // Allow ingress only from external IP of the system running OpenTofu/Terraform
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
