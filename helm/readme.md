
# HELM version : >= helm-3.2

That's complete solution to deploy application into kubernetes and which can be used inside cicd tools like Jenkins or something like that.

| key | value |
|--|--|
| bu | Business Unit |
| service | The name of application or service |
| env | Environment |
| version | Docker image version |


## **How to deploy applications into kubernetes**

    ./helm/scripts/helm-upgrade.sh $bu $service $env $version


**Here is to deploy with real world variable**

    ./helm/scripts/helm-upgrade.sh 'finance' 'gl-report' 'sit' 'v0.1.0'

**Here is to rollback**

    ./helm/scripts/helm-rollback.sh 'finance' 'gl-report'
