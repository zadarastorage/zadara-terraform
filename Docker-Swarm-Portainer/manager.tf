resource "aws_instance" "manager" {
  ami = "${var.ami}"
  instance_type = "t2.nano"
  subnet_id = "${var.subnet}"
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  key_name = "${var.keyname}"
  root_block_device {
    volume_size           = "20"
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
