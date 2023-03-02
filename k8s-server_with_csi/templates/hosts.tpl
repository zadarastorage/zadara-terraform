[k8smanagers]
k8smanager ansible_ssh_host=${manager-ip}

[k8sworkers]
%{ for index, ip in worker-ip ~}
k8sworker-${index} ansible_ssh_host=${ip}
%{ endfor }
