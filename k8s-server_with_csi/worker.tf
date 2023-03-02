
resource "aws_instance" "worker" {
  count = "${var.quantity-worker}"
  ami = "${var.ami}"
  instance_type = "z4.large"
  key_name = "${var.keyname}"
  subnet_id = "${var.subnet}"
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  user_data     = <<-EOF
    #! /bin/bash
    sudo sed -i "/search symphony.local/c\search symphony.local ""${var.domainname}" /etc/resolv.conf
    sudo apt install net-tools
    sudo dhclient

  EOF
  root_block_device {
    volume_size           = "50"
  }
  tags = {
  Name     = "${var.workername}${count.index}"
  }


}
resource "aws_network_interface" "worker" {
  subnet_id       = "${var.subnet}"
  security_groups = ["${aws_security_group.allow_all.id}"]
}
resource "aws_eip" "worker" {
  count = "${var.quantity-worker}"
  vpc = true
}
resource "aws_eip_association" "eip_worker" {
  instance_id        = "${element(aws_instance.worker.*.id,count.index)}"
  network_interface_id = aws_network_interface.worker.id
  allocation_id = "${element(aws_eip.worker.*.id,count.index)}"
  count = "${var.quantity-worker}"
}
