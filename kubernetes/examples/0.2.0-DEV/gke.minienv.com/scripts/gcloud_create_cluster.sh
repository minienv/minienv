#!/usr/bin/env bash
gcloud config set project minienv-xxx
gcloud container clusters create --zone us-central1-a --machine-type=n1-standard-2 --num-nodes=1 minienv-cluster
gcloud auth application-default login
gcloud compute firewall-rules create minienv-nodeports-rule --allow=tcp:30000-32767
gcloud compute addresses create minienv-ip --global