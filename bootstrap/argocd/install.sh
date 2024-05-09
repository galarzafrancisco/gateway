#!/bin/bash

# Create ns
kubectl create namespace argocd

# Apply
kubectl -n argocd apply -k ./overlays/develop