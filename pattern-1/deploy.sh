#!/usr/bin/env bash

# ------------------------------------------------------------------------
# Copyright 2017 WSO2, Inc. (http://wso2.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License
# ------------------------------------------------------------------------

# methods
function echoBold () {
    echo $'\e[1m'"${1}"$'\e[0m'
}

set -e

# configuration policy
echoBold 'Creating Configuration Policy...'
oc create user wso2ei #--full-name=wso2ei
#oc adm policy add-cluster-role-to-user cluster-admin wso2ei

# Create a new project called wso2ei
echoBold 'Creating Project...'
oc new-project wso2 --description="WSO2" --display-name="wso2"

# Create Service Account WSO2
echoBold 'Creating Configuration Service Account...'
oc create serviceaccount wso2svcacct
oc login -u system:admin -n wso2
oc adm policy add-scc-to-user anyuid -z wso2svcacct -n wso2
oc login -u developer -n wso2

# configuration maps
echoBold 'Creating Configuration Maps...'
cd pattern-1/
oc create configmap integrator-conf --from-file=conf/integrator/conf/
oc create configmap integrator-conf-axis2 --from-file=conf/integrator/conf/axis2/
oc create configmap integrator-conf-datasources --from-file=conf/integrator/conf/datasources/
oc create configmap integrator-conf-security --from-file=conf/integrator/conf/security/

# mysql
echoBold 'Deploying WSO2 Integrator Databases...'
oc create -f mysql-volume.yaml
oc create -f mysql-service.yaml
oc create -f mysql-deployment.yaml
sleep 10s

# integrator
echoBold 'Deploying WSO2 Integrator...'
oc create -f integrator-service.yaml
oc create -f integrator-gateway-service.yaml
oc create -f integrator-deployment.yaml
oc create -f integrator-route-gw.yaml
oc create -f integrator-route-ui.yaml
#oc login -u system:admin -n wso2
#oc create -f integrator-ingress.yaml
#oc login -u developer -n wso2

echoBold 'Finished'
echo 'To access the console, try https://wso2ei-pattern1-integrator/carbon in your browser.'


#oc expose service wso2ei-pattern1-integrator-service --port=9443 --hostname=ui-wso2.192.168.99.100.nip.io