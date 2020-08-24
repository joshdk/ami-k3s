build {
  sources = ["source.amazon-ebs.k3s"]

  provisioner "file" {
    source = "files"
    destination = "/tmp"
  }

  provisioner "shell" {
    script = "scripts/provision.sh"
  }
}
