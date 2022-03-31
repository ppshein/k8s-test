# e: immediately exit if error
# u: exit if refer to non existing variable
# o: return error code of any sub command in pipeline
set -euo pipefail

HELMDIR="$(dirname $(realpath "$0"))/.."

BU_NAME=$1
SERVICE_NAME=$2
ENV_NAME=$3
VERSION=$4

function get_value() {
  VAR=$1
  cat ./conf_tmps.toml | jq -r ".${VAR}" | tr -d '\n' | base64 --decode
}

function encode_value() {
  VAR=$1
  echo "$VAR" | tr -d '\n' | base64
}

if [ $# -ge 5 ]; then
  OPTION="${@:5}"
else
  OPTION=""
fi
echo "OPTION: " $OPTION

NAMESPACE=${SERVICE_NAME}-${ENV_NAME}
RELEASE_NAME="${BU_NAME}-${SERVICE_NAME}-${ENV_NAME}"
SECRET_ID="${BU_NAME}/${NAMESPACE}-secret"
REGION="ap-southeast-1"

echo $SECRET_ID

#fetch from secret manager
$HELMDIR/scripts/secret.sh $SECRET_ID

#retrive required info from conf.toml
DbUser=$(get_value "DbUser")
DbPassword=$(get_value "DbPassword")
DbName=$(get_value "DbName")
DbPort=$(get_value "DbPort")
DbHost=$(get_value "DbHost")
ListenHost=$(get_value "ListenHost")
ListenPort=$(get_value "ListenPort")

#create conf.toml file
cat > plain_conf.toml <<EOL
"DbUser" = "${DbUser}"
"DbPassword" = "${DbPassword}"
"DbName" = "${DbName}"
"DbPort" = "${DbPort}"
"DbHost" = "${DbHost}"
"ListenHost" = "${ListenHost}"
"ListenPort" = "${ListenPort}"
EOL

# # convert to encode files
base64 "./plain_conf.toml" > "./conf.toml"

# check if whether new release or not
if helm list --namespace $NAMESPACE | grep $NAMESPACE; then
  ACTION="upgrade"
else
  ACTION="install"
fi

echo "helm $ACTION $RELEASE_NAME --namespace $NAMESPACE"

helm $ACTION $RELEASE_NAME --namespace $NAMESPACE \
--create-namespace -f $HELMDIR/values/$ENV_NAME.yaml \
--set namespace=$NAMESPACE \
--set env=$ENV_NAME \
--set POSTGRES_USER=$(encode_value "${DbUser}") \
--set POSTGRES_PASSWORD=$(encode_value "${DbPassword}") \
--set POSTGRES_DB=$(encode_value "${DbName}") \
--set version=$VERSION \
$OPTION $HELMDIR

helm get manifest $RELEASE_NAME --namespace $NAMESPACE | kubectl get -f -

# delete all tmps files
rm -R *.toml