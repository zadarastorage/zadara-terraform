resource "aws_instance" "server" {
  count = "${var.quantity}"
  ami = "${var.ami}"
  instance_type = "${var.instance}"
  subnet_id     = "${var.subnet}"
  key_name      = "${var.keyname}"
  vpc_security_group_ids = [aws_security_group.nginx.id]
  user_data     = <<-EOF
    #! /bin/bash
    sudo apt update -y
    sudo apt install -y nginx-light
    sudo systemctl enable nginx
    sudo chmod +w /var/www/html
    sudo touch /var/www/html/index.html
    echo $HOSTNAME > /var/www/html/index.html
  EOF
  tags = {
  Name     = "${var.servername}${count.index}"
  }
}
