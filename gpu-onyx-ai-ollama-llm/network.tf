resource "aws_security_group" "allow_demo_traffic" {
  name        = "gpu_allow_demo_traffic"
  description = "Allow demo traffic in and all traffic out"
  vpc_id      = "${var.vpc}"

  ingress {
    description = "access from home broadband"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["1.2.3.4/32"]
  }

  ingress {
    description = "access from the office"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["5.6.7.8/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
