resource "aws_instance" "my_vm" {
  count                  = "${var.quantity_server}"
  ami                    = "${var.ami}"
  instance_type          = "${var.instance}"
  subnet_id              = "${var.subnet}"
  vpc_security_group_ids = [aws_security_group.allow_demo_traffic.id]
  key_name               = "${var.keyname}"

  # --- CLOUD-INIT CONFIGURATION ---
  # Strategy:
  # 1. We compress the individual files (docker-compose & setup.sh) using base64gzip.
  # 2. We inject those tiny compressed strings into cloud-init.yml.
  # 3. We compress the final cloud-init.yml again.
  user_data_base64 = base64gzip(templatefile("${path.module}/cloud-init.yml", {
    docker_compose_encoded = base64gzip(file("${path.module}/docker-compose.zadara.dev.yml"))
    setup_script_encoded   = base64gzip(file("${path.module}/setup.sh"))
  }))

  root_block_device {
    volume_size = "200"
  }

  tags = {
    Name = "${var.servername}${count.index}"
  }
}

resource "aws_network_interface" "my_vm" {
  subnet_id       = "${var.subnet}"
  security_groups = ["${aws_security_group.allow_demo_traffic.id}"]
}

resource "aws_eip" "my_vm" {
  count = "${var.quantity_server}"
  instance = aws_instance.my_vm[count.index].id
  vpc   = true
}

resource "aws_eip_association" "eip_server" {
  count                = "${var.quantity_server}"
  instance_id          = "${element(aws_instance.my_vm.*.id, count.index)}"
  network_interface_id = aws_network_interface.my_vm.id
  allocation_id        = "${element(aws_eip.my_vm.*.id, count.index)}"
}

output "eip_address" {
  value = aws_eip.my_vm[0].public_ip
  description = "The public IP address of the Elastic IP assigned to the VM."
}
