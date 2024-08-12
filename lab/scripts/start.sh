#!/bin/bash

set -e

export AWS_REGION="${AWS_REGION:-"us-west-2"}"
export REPOSITORY_OWNER=${REPOSITORY_OWNER:-"longthg-workshops"}
export REPOSITORY_NAME=${REPOSITORY_NAME:-"eks-workshop-v2-fork"}
export REPOSITORY_REF=${REPOSITORY_REF:-"wsl"}
export RESOURCES_PRECREATED="true"

curl -fsSL https://raw.githubusercontent.com/${RepositoryOwner}/${RepositoryName}/${RepositoryRef}/lab/scripts/installer.sh | bash

sudo -E -H -u ec2-user bash -c "curl -fsSL https://raw.githubusercontent.com/${RepositoryOwner}/${RepositoryName}/${RepositoryRef}/lab/scripts/setup.sh | bash"
