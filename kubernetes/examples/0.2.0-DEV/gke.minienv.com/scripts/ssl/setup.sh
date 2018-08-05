#!/usr/bin/env bash
helm install --name cert-manager --namespace kube-system stable/cert-manager
gcloud iam service-accounts create clouddns --display-name=clouddns --project=minienv-xxx
gcloud iam service-accounts keys create ./clouddns.key.json --iam-account=clouddns@minienv-xxx.iam.gserviceaccount.com --project=minienv-xxx
gcloud projects add-iam-policy-binding minienv-1 --member=serviceAccount:clouddns@minienv-xxx.iam.gserviceaccount.com --role=roles/dns.admin
kubectl create secret generic minienv-clouddns-secret --from-file=./clouddns.key.json
kubectl create -f issuer-prod.yml
kubectl create -f certificate-standard-prod.yml
kubectl create -f certificate-wildcard-prod.yml
