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

IP="";
# Waiting for LoadBalancer assignment for svc 
while [ -z $IP ]; 
do echo "Waiting for end point..."; 
IP=$(kubectl get svc kubera-ingress-nginx-controller -n kubera --template="{{range .status.loadBalancer.ingress}}{{.hostname}}{{end}}"); 
[ -z "$IP" ] && sleep 10; 
done; 

URL=http://$IP

# Waiting for URL to be active
until $(curl --output /dev/null --silent --head --fail $URL); do
    printf '.'
    sleep 5
done

echo "URL to access Kubera-Core: $URL"

Storing URL as env variable
echo "URL=$URL" > url.txt


