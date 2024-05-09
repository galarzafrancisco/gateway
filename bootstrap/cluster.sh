#!/bin/bash

# Create a kubernetes cluster in GCP if it doesn't already exist.
# Actually I'll do it manually because it's too simple. Just create a project, enable billing, enable the kube api
# and create a cluster.

# Normal cluster
gcloud beta container \
  --project "gateway-422801" \
  clusters create "blob-1" \
  --no-enable-basic-auth \
  --cluster-version "1.28.7-gke.1026000" \
  --release-channel "regular" \
  --machine-type "e2-small" \
  --image-type "COS_CONTAINERD" \
  --disk-type "pd-balanced" \
  --disk-size "100" \
  --metadata disable-legacy-endpoints=true \
  --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --spot --num-nodes "1" --logging=SYSTEM,WORKLOAD --monitoring=SYSTEM --enable-ip-alias --network "projects/gateway-422801/global/networks/default" --subnetwork "projects/gateway-422801/regions/australia-southeast1/subnetworks/default" --no-enable-intra-node-visibility --default-max-pods-per-node "110" --security-posture=standard --workload-vulnerability-scanning=disabled --no-enable-master-authorized-networks --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver \
  --enable-autoupgrade \
  --enable-autorepair \
  --max-surge-upgrade 1 \
  --max-unavailable-upgrade 0 \
  --binauthz-evaluation-mode=DISABLED \
  --enable-managed-prometheus \
  --enable-shielded-nodes \
  --fleet-project=gateway-422801 \
  --node-locations "australia-southeast1-a" \
  --zone "australia-southeast1-a"

# Configure kubectl
gcloud container clusters get-credentials blob-1 --zone australia-southeast1-a --project gateway-422801

# Autopilot cluster
# gcloud beta container \
#   --project "gateway-422801" \
#   clusters create-auto "blob-1" \
#   --region "australia-southeast1" \
#   --release-channel "regular" \
#   --network "projects/gateway-422801/global/networks/default" \
#   --subnetwork "projects/gateway-422801/regions/australia-southeast1/subnetworks/default" \
#   --cluster-ipv4-cidr "/17" \
#   --binauthz-evaluation-mode=DISABLED \
#   --fleet-project=gateway-422801

