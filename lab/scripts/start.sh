#!/bin/bash

set -e

export AWS_REGION="${AWS_REGION:-"us-west-2"}"
export REPOSITORY_OWNER=${REPOSITORY_OWNER:-"longthg-workshops"}
export REPOSITORY_NAME=${REPOSITORY_NAME:-"eks-workshop-v2-fork"}
export REPOSITORY_REF=${REPOSITORY_REF:-"cloud-ide"}
export RESOURCES_PRECREATED="true"
export ENVIRONMENT=${ENVIRONMENT:-"${HOME}/eks-workshop-aws"}

curl -fsSL https://raw.githubusercontent.com/${REPOSITORY_OWNER}/${REPOSITORY_NAME}/${REPOSITORY_REF}/lab/scripts/installer.sh | bash

sudo -E -H -u ubuntu bash -c "curl -fsSL https://raw.githubusercontent.com/${REPOSITORY_OWNER}/${REPOSITORY_NAME}/${REPOSITORY_REF}/lab/scripts/setup.sh | bash"
