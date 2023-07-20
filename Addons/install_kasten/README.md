# Install Kasten K10 by Veeam Addon

All use the official Hashicorp AWS Provider https://registry.terraform.io/providers/hashicorp/aws/latest/docs

Update the install_k10.tf file with our password. It will be stored encrypted ( via htpasswd) in a secret. 
You must run the following command in the install_kasten folder
- terraform init
- terraform plan
- terraform apply

##Access the Dashboard
run the following command after the installation is ready on your masternode
kubectl --namespace kasten-io port-forward service/gateway --address 0.0.0.0 8080:8000 &
Now you can access the Dashboard via your masternode IP
http://<your_masternode_ip>:8080/k10/#
