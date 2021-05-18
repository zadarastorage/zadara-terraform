# Docker Swarm with Portainer Portal Example
This script deploy 1 docker swarm manager and a variable amount of worker nodes.
For the Network, Security Group and Server we use Terraform.
After all server are created and the elastic ip are assigned, terraform start a Ansible playbook that install docker with all dependencies, install swarm, create the cluster and add all worker vm’s to the cluster.
After docker and swarm is ready, Ansible install the portainer management portal as a docker container.

## Prepare the Script
To prepare the script with your credential and variables, update the variable.tf Script


## Run the Script
This Example used the official Hashicorp AWS Provider https://registry.terraform.io/providers/hashicorp/aws/latest/docs

After you have adjust the variable.tf file you must run the following command
- terraform init
- terraform plan
- terraform apply

###Now the customer can reach the portioner guide via http://manager-ip:9000

## Details
- connect.tf define the general connection to the defined zCloud environment.
- network.tf create the used security security group
- manager.tf create the master server
- worker.tf create the worker servers
- postscript.tf runs the ansible playbook
- ansible.cfg define the ansible variables
- workload.yaml is the ansible playbook for docker installation
- under roles are the ansible scripts to create the swarm cluster and install portainer
- inventory is the ansible inventory
- templates define how the ips are stored in the inventory
