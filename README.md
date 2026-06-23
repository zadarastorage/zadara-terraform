# Terraform with Zadara Compute

All examples use the official [Hashicorp AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) using version `3.33.0`.

## Zadara Compute Provider configuration

Using variables for `accesskey`, `secretkey`, and `zcompute_base_url`, the following is an example configuration for using the Hashicorp AWS provider with Zadara Compute: 

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.33.0"
    }
  }
}

provider "aws" {
    access_key = var.accesskey
    secret_key = var.secretkey
    endpoints {
        ec2 = "https://${var.zcompute_base_url}/api/v2/ec2"
        iam = "https://${var.zcompute_base_url}/api/v2/aws/iam"
    }
    insecure                    = "true"
    skip_metadata_api_check     = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    region                      = "us-east-1"
}
```

## This Repository provides several zCompute Terraform examples

- Addons contains terrraform examples that can added to an existing kubernetes cluster
- Basic-server is an example to deploy 2 simple server VM's
- Loadbalancer is an example to deploy an Application Loadblancer with 4 Web servers
- K8s (DEPRECATED) see https://github.com/zadarastorage/zadara-examples/tree/main/k8s 
- K8s_with_CSI (DEPRECATED) see https://github.com/zadarastorage/zadara-examples/tree/main/k8s
- GPU VM with Onyx AI installed using Ollama LLM
