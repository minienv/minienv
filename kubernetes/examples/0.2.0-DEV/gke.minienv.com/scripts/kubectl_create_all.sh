#!/usr/bin/env bash
kubectl create -f ../clusterrolebindings.yml
kubectl create -f ../namespace.yml
kubectl create -f ../daemonset-registry.yml
kubectl create -f ../daemonset-npm-proxy-cache.yml
kubectl create -f ../secret-probot.yml
kubectl create -f ../deployment-api.yml
kubectl create -f ../deployment-web.yml
kubectl create -f ../deployment-probot.yml
kubectl create -f ../service-api.yml
kubectl create -f ../service-web.yml
kubectl create -f ../service-probot.yml
kubectl create -f ../ingress.yml