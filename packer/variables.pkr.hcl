variable "aws_access_key" {
  description = "AWS Access Key"
  type = string
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key"
  type = string
}

variable "aws_region" {
  description = "AWS Region to build AMI"
  type = string
}

variable "version" {
  description = "Version stamp"
  type = string
}
