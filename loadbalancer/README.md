# Loadbalancer Example
Example Script to deploy 4 Webserver with a loadbalancer
The Application Loadbalacer get a Elastic IP and listen to Port 80
Each Webserver has a static Webpage which provide the hostname of the corresponding Server

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
- loadbalancer.tf create the loadbalancer instance with target group and listener 
