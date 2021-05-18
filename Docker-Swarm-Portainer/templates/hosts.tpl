[swarm-managers]
swarm-manager ansible_ssh_host=${manager-ip}

[swarm-workers]
%{ for index, ip in worker-ip ~}
swarm-worker-${index} ansible_ssh_host=${ip}
%{ endfor }
