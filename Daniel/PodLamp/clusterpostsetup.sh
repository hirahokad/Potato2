#! /bin/bash
# Displays nodes of the Cluster
kubectl get nodes

# Creates Dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

# Gives cluster info 
kubectl cluster-info

# For Dashboard access
kops get secrets kube --type secret -oplaintext
kops get secrets admin --type secret -oplaintext
