#!/bin/sh

set -e

#base64 encoded Kube Config file:
echo ${KUBE_CONFIG_DATA} | base64 -d > kubeconfig
chmod go-r ${PWD}/kubeconfig
export KUBECONFIG="${PWD}/kubeconfig"

echo "running entrypoint command(s)"

response=$(sh -c " $*")

echo "::set-output name=response::$response"