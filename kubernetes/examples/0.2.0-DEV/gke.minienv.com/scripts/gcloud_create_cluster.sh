#!/usr/bin/env bash
gcloud config set project <YOUR_GCP_PROJECT_NAME>
gcloud container clusters create --zone us-central1-a --machine-type=n1-standard-2 --num-nodes=1 minienv-cluster
gcloud auth application-default login
gcloud compute addresses create minienv-ip --region us-central1