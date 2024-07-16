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

resource "aws_eip" "server" {
  count = "${var.quantity-server}"
  instance = aws_instance.server[count.index].id
}

resource "aws_eip_association" "eip_server" {
  count = "${var.quantity-server}"
  instance_id   = aws_instance.server[count.index].id
  allocation_id = aws_eip.server[count.index].id
}
