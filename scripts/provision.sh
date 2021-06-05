#!/usr/bin/env bash
set -euo pipefail

main() {
    # Update base system.
    sudo yum update -y

    # Install additional packages.
    sudo yum install -y git

    # Remove unused services.
    sudo yum erase -y \
        postfix \
        rpcbind

    # Download and install kustomize.
    wget --quiet https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.1.3/kustomize_v4.1.3_linux_amd64.tar.gz
    tar -xvf kustomize_v4.1.3_linux_amd64.tar.gz
    sudo install kustomize /usr/bin/kustomize

    # Download the official k3s installer.
    wget -q -O /tmp/files/k3s-install.sh https://raw.githubusercontent.com/rancher/k3s/v1.21.1+k3s1/install.sh
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
