#!/bin/bash

set -e

ENVIRONMENT=${ENVIRONMENT:-"${HOME}/eks-workshop-aws"}

if [[ ! -d "${HOME}/.bashrc.d" ]]; then
  mkdir -p ${HOME}/.bashrc.d
  
  touch ${HOME}/.bashrc.d/dummy.bash

  echo 'for file in ${HOME}/.bashrc.d/*.bash; do source "$file"; done' >> ${HOME}/.bashrc
fi

if [ ! -z "$CLOUD9_ENVIRONMENT_ID" ]; then
  echo "aws cloud9 update-environment --environment-id $CLOUD9_ENVIRONMENT_ID --managed-credentials-action DISABLE &> /dev/null || true" > ${HOME}/.bashrc.d/c9.bash
fi

cat << EOT > ${HOME}/.bashrc.d/aws.bash
export AWS_PAGER=""
export AWS_REGION="${AWS_REGION}"
EOT

touch ${HOME}/.bashrc.d/workshop-env.bash

cat << EOT > ${HOME}/.bashrc.d/aliases.bash
function prepare-environment() { 
  bash /usr/local/bin/reset-environment \$1
  exit_code=\$?
  source ${HOME}/.bashrc.d/workshop-env.bash
  return \$exit_code
}

function use-cluster() { bash /usr/local/bin/use-cluster \$1; source ${HOME}/.bashrc.d/env.bash; }
EOT

REPOSITORY_OWNER=${REPOSITORY_OWNER:-"longthg-workshops"}
REPOSITORY_NAME=${REPOSITORY_NAME:-"eks-workshop-v2-fork"}
REPOSITORY_REF=${REPOSITORY_REF:-"wsl"}

if [ ! -z "$REPOSITORY_REF" ]; then
  cat << EOT > ${HOME}/.bashrc.d/repository.bash
export REPOSITORY_OWNER='${REPOSITORY_OWNER}'
export REPOSITORY_NAME='${REPOSITORY_NAME}'
export REPOSITORY_REF='${REPOSITORY_REF}'
EOT
fi

RESOURCES_PRECREATED=${RESOURCES_PRECREATED:-"false"}

echo "export RESOURCES_PRECREATED='${RESOURCES_PRECREATED}'" > ${HOME}/.bashrc.d/infra.bash

echo "export ANALYTICS_ENDPOINT='${ANALYTICS_ENDPOINT}'" > ${HOME}/.bashrc.d/analytics.bash

/usr/local/bin/kubectl completion bash >  ${HOME}/.bashrc.d/kubectl_completion.bash
echo "alias k=kubectl" >> ${HOME}/.bashrc.d/kubectl_completion.bash
echo "complete -F __start_kubectl k" >> ${HOME}/.bashrc.d/kubectl_completion.bash