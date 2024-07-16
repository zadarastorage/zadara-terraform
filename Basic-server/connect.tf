terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.33.0"
    }
  }
}

provider "aws" {
    #tenant
    access_key = var.accesskey
    secret_key = var.secretkey
    #zCloud endpoints
    endpoints {
        ec2 = "https://${var.zcloud_ip}/api/v2/ec2"
        iam = "https://${var.zcloud_ip}/api/v2/aws/iam"
    }
    insecure                    = "true"
    skip_metadata_api_check     = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    region                      = "us-east-1"
}
