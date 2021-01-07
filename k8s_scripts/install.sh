#!/bin/bash
set -ex
path=$(pwd)

# # Setting up the kubeconfig
mkdir -p ~/.kube
# cp $path/.awscluster2/config ~/.kube/config
cp $path/.kube/config ~/.kube/config
cp $path/.kube/admin.conf ~/.kube/config

# Booting up the kubera Setup
kubectl create ns kubera
kubectl get nodes 
helm repo add kubera https://charts.mayadata.io  
helm install kubera kubera/kubera-enterprise --namespace=kubera

echo "Pods Running in Kubera Namespace"
kubectl get pods -n kubera

echo "Services Running in Kubera Namespace"
kubectl get svc -n kubera

# Waiting for pods to be ready
kubectl wait --for=condition=Ready pods --all --namespace kubera --timeout=120s

# # Getting latest kubeconfig in cache
cat ~/.kube/config > $path/.kube/config
cat ~/.kube/config > $path/.kube/admin.conf