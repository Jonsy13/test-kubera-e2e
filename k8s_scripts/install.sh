#!/bin/bash
set -ex
path=$(pwd)

# # Setting up the kubeconfig
mkdir -p ~/.kube

cp $path/.kube/config ~/.kube/config
cp $path/.kube/admin.conf ~/.kube/config

# Booting up the kubera Setup
kubectl create ns kubera
kubectl get nodes 
helm repo add kubera https://charts.mayadata.io
helm repo update  
helm install kubera kubera/kubera-enterprise --namespace=kubera

echo "Pods Running in Kubera Namespace"
kubectl get pods -n kubera

echo "Services Running in Kubera Namespace"
kubectl get svc -n kubera

# Waiting for pods to be ready
kubectl wait --for=condition=Ready pods --all --namespace kubera --timeout=120s

# Getting The LoadBalancer IP for accessing Kubera-core
kubectl patch svc kubera-ingress-nginx-controller -p '{"spec": {"type": "LoadBalancer"}}' -n kubera
IP=$(kubectl get svc -n kubera --no-headers |awk '/kubera-ingress-nginx-controller/ {print $4}' | head -n 1)
URL=http://$IP

# Waiting for URL to be active
until $(curl --output /dev/null --silent --head --fail $URL); do
    printf '.'
    sleep 5
done

echo "URL to access Kubera-Core: $URL"

# # Getting latest kubeconfig in cache
cat ~/.kube/config > $path/.kube/config
cat ~/.kube/config > $path/.kube/admin.conf