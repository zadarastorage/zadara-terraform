# zCompute L40/L40S GPU VM + Onyx AI + Ollama LLM
An example set of scripts to deploy an Ubuntu 24.04 VM with GPU and install the components required to run Onyx AI Chat privately.


## Prepare the scripts
Two of the scripts must be customised to work in your cloud / account as follows:

1. variables.tf

Configure the following lines with the details obtained from within your zCompute account:

- Access key (generated in zCompute)
- Secret key (generated in zCompute)
- Cloud URL (something.zadara.com)
- Quantity of servers
- A name for the server
- SSH key name (the name of the key you generated in zCompute)
- Instance type (e.g. GPU_L4.4xlarge or GPU_L40S.4xlarge)
- The image AMI ID (the AWS ID displayed in zCompute e.g. Ubuntu 24.04)
- VPC ID (your AWS ID displayed in zCompute)
- Subnet ID (your AWS ID displayed in zCompute)

2. network.tf

- Update the "cidr_blocks" line with your source/egress IP i.e. cidr_blocks = ["your IP here/32"]
- More than one source location can be added (in a separate "ingress" block).
- Google "what is my IP address" to find your IP(s).


## Run Terraform
This example uses the official Hashicorp AWS Provider https://registry.terraform.io/providers/hashicorp/aws/latest/docs

After reconfiguring the variables.tf and network.tf files run the following commands to prepare and build the environment:
- terraform init
- terraform plan
- terraform apply

To delete the VM afterwards:
- terraform destroy


## Next steps...

Estimated timings:
- Terraform script to run: ~1 minute
- VM to complete the installation: ~12 minutes
- terraform destryy: ~1 minute


Using the Public IP (eip_address) displayed at the end of the terraform script, SSH into the new VM and enter:
- tail -f /var/log/cloud-init-output.log

This will display the packages being installed and the creation of Docker containers through to completion.

Near the end of the process you will see "docker ps" displays the status of all of the containers, which should all be "Up".

Once installation is complete, in a web browser go to the public IP address e.g. http://<eip_address>

You should see the "Welcome to Onyx" login page.

Create an Account.

Once logged in, navigate to: “Admin Panel → LLM → Ollama → Set up”

Complete the following:

- Display Name: Ollama
- API Base: http://ollama:11434
- Click “Fetch Available Models”
- Default model: get-ups:20b
- Set “Fast Model” to: qwen3:1.7b
- Under “Advanced Options” tick all 3 boxes under “Display Models”.
- Click “Enable”.
- Finally, “Exit Admin”.

The LLM is ready to go… start asking questions.


## Utilities:
- Run "nvtop" on the CLI to display GPU usage.
- Portainer: Access at https://<eip_address>:9000 to manage containers, monitor services, logs, and pull images.
- Glances: Access at http://<eip_address>:61208 for real-time monitoring of CPU, memory, disk, and Docker stats.
