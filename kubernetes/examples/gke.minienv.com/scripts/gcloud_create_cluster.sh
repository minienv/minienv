#!/usr/bin/env bash
gcloud config set project minienv-xxx
gcloud container clusters create --machine-type=g1-small --num-nodes=2 minienv-cluster
gcloud auth application-default login
gcloud compute firewall-rules create minienv-nodeports-rule --allow=tcp:30000-32767