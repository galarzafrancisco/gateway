#!/bin/bash

# Create ns
kubectl create namespace argocd

# Apply
kubectl -n argocd apply -k ./argocd/overlays/develop
kubectl -n argocd apply -f ./applicationset