#!/usr/bin/env bash
set -euo pipefail

K3S_KUBECONFIG_MODE=644 \
INSTALL_K3S_EXEC="--disable traefik --disable-helm-controller" \
    /usr/local/bin/k3s-install.sh

echo "Waiting for k3s to be ready..."
sleep 30

kubectl get no -o=wide
kubectl get all --all-namespaces -o=wide
