terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.73.0"
    }
  }

  backend "s3" {
    bucket = "vivian-nakano"
    key    = "aws-vpc-provider/terraform.tfstate"
    region = "sa-east-1"
  }
}

##principal
provider "aws" {
  region = "sa-east-1"

  default_tags {
    tags = {
      owner      = "vivian-nakano"
      managed-by = "terraform"
      region     = "sa-east-1"
    }
  }
}

provider "aws" {
  alias  = "eua" ##o secundário para frente precisa do alias
  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "vivian-nakano"
      managed-by = "terraform"
      region     = "us-east-1"
    }
  }
}

###ARQUIVO NETWORK

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "vpc-provider-terraform"
  }
}

resource "aws_vpc" "vpc-eua" {
  provider = aws.eua

  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "vpc-provider-terraform"
  }
}
