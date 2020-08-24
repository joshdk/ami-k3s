#!/usr/bin/env bash
set -euo pipefail

main() {
    # Update base system.
    sudo yum update -y

    # Remove unused services.
    sudo yum erase -y \
        postfix \
        rpcbind

    # Install Helm.
    wget --quiet https://get.helm.sh/helm-v3.3.0-linux-amd64.tar.gz
    tar -xvf helm-v3.3.0-linux-amd64.tar.gz
    sudo install linux-amd64/helm /usr/bin/helm

    # Download the official k3s installer.
    wget -q -O /tmp/files/k3s-install.sh https://raw.githubusercontent.com/rancher/k3s/v1.18.8%2Bk3s1/install.sh
    sudo install /tmp/files/k3s-install.sh /usr/local/bin/k3s-install.sh

    # Install the on-boot k3s setup Systemd unit.
    sudo install /tmp/files/k3s-boot.sh /usr/local/bin/k3s-boot.sh
    sudo install /tmp/files/k3s-boot.service /usr/lib/systemd/system/k3s-boot.service
    sudo systemctl enable k3s-boot.service

    # Clean up temporary files.
    rm -rf /tmp/files
}

cd "$(mktemp -d)"
main
rm -rf "$PWD"
