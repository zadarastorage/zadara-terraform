# Basic Server Example
Example Script to create a user and generate a new Access Key for that user. 


## Prepare the Script
To prepare the script with your credential and variables, update the variable.tf Script or provide the variables via envvars or command line prompts.

## Run the Script
This Example used the official Hashicorp AWS Provider https://registry.terraform.io/providers/hashicorp/aws/3.33.0/docs

After you have adjust the variable.tf file you must run the following command
- terraform init
- terraform plan
- terraform apply


## Details
- connect.tf define the general connection to the defined zCloud environment.
- user.tf creates the user and access key
