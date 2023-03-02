
resource "local_file" "AnsibleInventory" {
  content = templatefile("templates/hosts.tpl", {
    manager-ip = aws_eip.manager.public_ip
    worker-ip = aws_eip.worker.*.public_ip
    })
  filename = "inventory/hosts.yaml"
}




resource "null_resource" "ansible_load" {

    provisioner "local-exec" {
      command = "sleep 80"
    }
   provisioner "local-exec" {
      command = "ansible-playbook -i inventory/hosts.yaml k8s_prereqs.yaml --extra-vars managerip='${aws_instance.manager.public_ip}'"

    }
   provisioner "local-exec" {
      command = "ansible-playbook -i inventory/hosts.yaml k8s_server.yaml --extra-vars managerip='${aws_instance.manager.public_ip}'"

    }
   provisioner "local-exec" {
      command = "ansible-playbook -i inventory/hosts.yaml k8s_worker.yaml --extra-vars managerip='${aws_instance.manager.public_ip}'"

    }
   provisioner "local-exec" {
      command = "ansible-playbook -i inventory/hosts.yaml k8s_csi.yaml --extra-vars='{vpsahostname: ${var.vpsahostname}}' --extra-vars='{vpsatoken: ${var.vpsatoken}}' "
    }


    depends_on = [aws_eip_association.eip_worker]
  }
