#!/bin/bash

set -e

logmessage "Deleting ArgoCD applications..."

delete-all-and-wait-if-crd-exists applications.argoproj.io

rm -rf ${HOME}/environment/argocd

uninstall-helm-chart argocd argocd