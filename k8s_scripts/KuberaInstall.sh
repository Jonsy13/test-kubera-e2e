#!/bin/bash
set -e
path=$(pwd)

# Setting up the kubeconfig
mkdir -p ~/.kube
cat $path/.kube/config > ~/.kube/config
cat $path/.kube/admin.conf > ~/.kube/config

# Booting up the kubera Setup
kubectl create ns kubera
helm install kubera kubera/kubera-enterprise --namespace=kubera

echo "Pods Running in Kubera Namespace"
kubectl get pods -n kubera

echo "Services Running in Kubera Namespace"
kubectl get svc -n kubera

# Getting latest kubeconfig in cache
cat ~/.kube/config > $path/.kube/config
cat ~/.kube/config > $path/.kube/admin.conf

# Waiting for pods to be ready
kubectl wait --for=condition=Ready pods --all --namespace kubera --timeout=120s