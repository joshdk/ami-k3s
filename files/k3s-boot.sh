#!/usr/bin/env bash
set -euo pipefail

K3S_KUBECONFIG_MODE=644 \
INSTALL_K3S_EXEC="--no-deploy traefik" \
    /usr/local/bin/k3s-install.sh

echo "Waiting for k3s to be ready..."
sleep 30

k3s kubectl get no -o=wide
k3s kubectl get all --all-namespaces -o=wide

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install nginx-ingress ingress-nginx/ingress-nginx \
    --kubeconfig /etc/rancher/k3s/k3s.yaml \
    --namespace kube-system \
    --set defaultBackend.enabled=false