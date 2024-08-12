#!/bin/bash

set -e

logmessage "Uninstalling flux"

flux uninstall --silent

kubectl delete namespace ui

rm -rf ${HOME}/environment/flux