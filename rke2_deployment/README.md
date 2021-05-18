# RKE2 Kubernetes Example
Example Script to deploy a RKE2 Master with 2 Worker Nodes

## Ansible must be installed on your workstation

## Prepare the Script
To prepare the script with your credential and variables, update the variable.tf Script

## Run the Script
This Example used the official Hashicorp AWS Provider https://registry.terraform.io/providers/hashicorp/aws/latest/docs

After you have adjust the variable.tf file you must run the following command
- terraform init
- terraform plan
- terraform apply


## Details
- connect.tf define the general connection to the defined zCloud environment.
- network.tf create the used security security group
- server.tf create the webserver and install NGINX with a static index.html
