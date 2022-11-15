provider "aws" {
    #tenant
    access_key = "${var.accesskey}"
    secret_key ="${var.secretkey}"
    #zCloud endpoints
    endpoints {
        ec2 = "https://${var.zcloud_ip}/api/v2/aws/ec2"
        elb = "https://${var.zcloud_ip}/api/v2/aws/elb"
        route53 = "https://${var.zcloud_ip}/api/v2/aws/route53"
        }
    insecure = "true"
    skip_metadata_api_check = true
    skip_credentials_validation = true
    skip_requesting_account_id = true
    version = "2.13"
    region = "us-east-1"
  }
