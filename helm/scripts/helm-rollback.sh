# e: immediately exit if error
# u: exit if refer to non existing variable
# o: return error code of any sub command in pipeline
set -euo pipefail

HELMDIR="$(dirname $(realpath "$0"))/.."

SERVICE_NAME=$1
ENV_NAME=$2

NAMESPACE=${SERVICE_NAME}-${ENV_NAME}
RELEASE_NAME=$NAMESPACE

helm rollback $RELEASE_NAME
