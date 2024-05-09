#!/bin/bash


# Create a kubernetes cluster in GCP if it doesn't already exist
./cluster.sh

# Install ArgoCD
./argocd.sh

# Install the ArgoCD application set to watch this repo