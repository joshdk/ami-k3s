source "amazon-ebs" "k3s" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key

  source_ami_filter {
    filters = {
      name = "amzn2-ami-hvm-*-x86_64-gp2"
      root-device-type = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners = [
      "137112412989" # Amazon
    ]
  }

  ami_description = "Boot into k3s"
  ami_name = "k3s-${var.version}"
  instance_type = "t2.micro"
  region = var.aws_region
  ssh_timeout = "5m"
  ssh_username = "ec2-user"

  tags = {
    Base = "{{.SourceAMIName}}"
    Name = "k3s-${var.version}"
    Origin = "https://github.com/joshdk/ami-k3s"
    Timestamp = "{{isotime}}"
    Version = var.version
  }
}
