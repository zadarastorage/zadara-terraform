# Basic Server Example
Example Script to deploy 2 Linux VM's (quantity can be adjust)


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
- server.tf deploy a standard server
