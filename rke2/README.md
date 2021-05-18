# RKE2 Kubernetes Example
Example Script to deploy a RKE2 Master with 2 Worker Nodes


## Prepare the Script
To prepare the script with your credential and variables, update the variable.tf Script

You must install Ansible before you run the script > brew install ansible

Please make sure your ssh private key is not too open 600 is ok and add you ssh key to the ssh cache with ssh-add ~/.ssh/id_rsa

## Run the Script
This Example used the official Hashicorp AWS Provider https://registry.terraform.io/providers/hashicorp/aws/latest/docs

After you have adjust the variable.tf file you must run the following command
- terraform init
- terraform plan
- terraform apply


## Details
- connect.tf define the general connection to the defined zCloud environment.
- network.tf create the used security security group
- manager.tf create the master server
- worker.tf create the worker servers
- postscript.tf runs the asible playbook
- ansible.cfg define the ansible variables
- rke2_server.yaml is the Ansible script to install the prereqs and RKE2
- rke2_worker.yaml is the Ansible script to install the prereqs and join to the master server
- buffer/rke2manager is a buffer to store the token for joining the worker nodes
- inventory is the Ansible inventory
- templates define how the ips are stored in the inventory
