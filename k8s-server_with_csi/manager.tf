
resource "aws_instance" "manager" {

  ami = "${var.ami}"
  instance_type = "z4.large"
  key_name = "${var.keyname}"
  subnet_id = "${var.subnet}"
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  user_data     = <<-EOF
    #! /bin/bash
    sudo sed -i "/search symphony.local/c\search symphony.local ""${var.domainname}" /etc/resolv.conf
    sudo apt install net-tools


  EOF
  root_block_device {
    volume_size           = "50"
  }


  tags = {
  Name     = "${var.managername}"
  }

}
resource "aws_network_interface" "manager" {
  subnet_id       = "${var.subnet}"
  security_groups = ["${aws_security_group.allow_all.id}"]
}


resource "aws_eip" "manager" {
  vpc = true
}
resource "aws_eip_association" "eip_manager" {
  instance_id        = aws_instance.manager.id
  network_interface_id = aws_network_interface.manager.id
  allocation_id = aws_eip.manager.id

}



resource "aws_route53_record" "manager" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "${var.managername}.${aws_route53_zone.main.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.manager.private_ip]
}
