[k3s_master]
k3s-master ansible_ssh_host=${manager-ip} ansible_user=ubuntu 
[k3s_workers]
%{ for index, ip in worker-ip ~}
k3s-worker${index} ansible_ssh_host=${ip} ansible_user=ubuntu 
%{ endfor }


[k3s_cluster:children]
k3s_master
k3s_workers

[all:vars]
ansible_ssh_private_key_file=CHANGEME
ansible_ssh_common_args='-o StrictHostKeyChecking=no'