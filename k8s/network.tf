// determine the external IP of the system running OpenTofu/Terraform
data "http" "myip" {
  url = "https://ip.rights.ninja/ip"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all_k8s-test"
  description = "Allow all outbout, allow only me inbound"
  vpc_id      = "${var.vpc}"

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
resource "aws_route53_zone" "main" {
  name = "${var.domainname}."
  vpc {
    vpc_id = "${var.vpc}"
  }
  lifecycle {
    ignore_changes = [vpc]
  }
}
