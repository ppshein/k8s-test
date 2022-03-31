# HELM version : >= helm-3.2
# servian-go
bu=eor
service=my-micro-service
env=sit
version=v0.1.0

./helm/my-task/scripts/helm-upgrade.sh $bu $service $env $version

example
./helm/my-task/scripts/helm-upgrade.sh 'finance' 'gl-report' 'sit' 'v0.1.0'

rollback
./helm/my-task/scripts/helm-upgrade.sh 'finance' 'gl-report'