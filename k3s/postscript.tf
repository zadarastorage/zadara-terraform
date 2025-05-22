
resource "local_file" "AnsibleInventory" {
  content = templatefile("templates/hosts.tpl", {
    manager-ip = aws_eip.manager.public_ip
    worker-ip = aws_eip.worker.*.public_ip
    })
  filename = "inventory/hosts.yaml"
}

resource "null_resource" "ansible_load" {

  provisioner "local-exec" {
    command = "sleep 40"
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i inventory/hosts.yaml k3s.yaml "
  }
  depends_on = [aws_eip_association.eip_manager]
}
