resource "aws_instance" "server" {
  count = "${var.quantity-server}"
  ami = "${var.ami}"
  instance_type = "${var.instance}"
  subnet_id = "${var.subnet}"
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  key_name = "${var.keyname}"
  root_block_device {
    volume_size           = "10"
  }
  tags = {
  Name     = "${var.servername}${count.index}"
  }
}
resource "aws_network_interface" "server" {
  subnet_id       = "${var.subnet}"
  security_groups = ["${aws_security_group.allow_all.id}"]
}
resource "aws_eip" "server" {
  count = "${var.quantity-server}"
  vpc = true
}
resource "aws_eip_association" "eip_server" {
  instance_id        = "${element(aws_instance.server.*.id,count.index)}"
  network_interface_id = aws_network_interface.server.id
  allocation_id = "${element(aws_eip.server.*.id,count.index)}"
  count = "${var.quantity-server}"
}
