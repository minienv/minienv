#!/usr/bin/env bash
kubectl delete namespace minienv
kubectl delete ingress minienv-ingress
kubectl delete service minienv-probot-service
kubectl delete deployment minienv-probot-deployment
kubectl delete service minienv-web-service
kubectl delete deployment minienv-web-deployment
kubectl delete service minienv-api-service
kubectl delete deployment minienv-api-deployment
kubectl delete daemonset minienv-npm-proxy-cache-daemonset
kubectl delete daemonset minienv-registry-daemonset
kubectl delete clusterrolebinding minienv-cluster-admin-crb