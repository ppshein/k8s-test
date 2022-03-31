#!/bin/sh
<<DOC
  .SYNOPSIS
    Apply terraform
  .POSITION_PARAMETER BU
    Business unit
  .POSITION_PARAMETER PROJECT
    Project name
  .POSITION_PARAMETER ENV
    Environment name
  .EXAMPLE
    ./apply.sh finance myproject sit
DOC

# e: immediately exit if error
# u: exit if refer to non existing variable
# o: return error code of any sub command in pipeline
set -euo pipefail

BASEDIR=$(dirname $(realpath "$0"))
BU=$1
PROJECT=$2
ENV=$3
WORKSPACE="${BU}-${PROJECT}-${ENV}"

export AWS_SDK_LOAD_CONFIG="true"

cd $BASEDIR/..
terraform init
terraform fmt -recursive

exist=$(terraform workspace list | grep "$WORKSPACE$" || :)
if [[ -z $exist ]]; then
  terraform workspace new $WORKSPACE
fi
terraform workspace select $WORKSPACE

echo "terraform apply -var-file=values/$ENV.tfvars"
terraform apply -var-file=values/$ENV.tfvars
