provider "aws" {
    #tenant
    access_key = "${var.accesskey}"
    secret_key ="${var.secretkey}"
    #zCloud endpoints
    endpoints {
        ec2 = "https://${var.zcloud_ip}/api/v2/ec2"
        }
    insecure = "true"
    skip_metadata_api_check = true
    skip_credentials_validation = true
    skip_requesting_account_id = true
    # AWS plugin version
    version = "=2.31.0"
    region = "us-east-1"
  }
