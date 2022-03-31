# e: immediately exit if error
# u: exit if refer to non existing variable
# o: return error code of any sub command in pipeline
set -euo pipefail

SECRET_ID=$1

aws secretsmanager get-secret-value --secret-id $SECRET_ID --region ap-southeast-1 --query SecretString --output text > ./conf_tmps.toml
