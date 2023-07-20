# install Zadara CSI Operator Addon

All use the official Hashicorp AWS Provider https://registry.terraform.io/providers/hashicorp/aws/latest/docs

## The installation and configuration is splitted in 2 parts.
Its important that you first use the install_csi.tf script
You must run the following command in the install_csi folder
- terraform init
- terraform plan
- terraform apply

## After the CSI helm chart are installed, change to the config_csi folder, please
Here run the following commands. The script ask you for your VPSA URL and your VPSA Token.
- terraform init
- terraform plan
- terraform apply

You can verify the installation with:
kubectl get vpsa
