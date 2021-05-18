[rke2managers]
rke2manager ansible_ssh_host=${manager-ip}

[rke2workers]
%{ for index, ip in worker-ip ~}
rke2worker-${index} ansible_ssh_host=${ip}
%{ endfor }
