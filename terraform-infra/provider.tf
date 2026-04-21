terraform { 

    backend "s3" {
        bucket = "gh-actions-demo1-tf-state-bucket"
        key = "terraform.tfstate"
        region = "us-west-2"
    }
}


provider "aws" {
    region = "eu-west-1"
}