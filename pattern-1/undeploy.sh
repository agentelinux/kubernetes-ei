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

# integrator
echoBold 'Un-deploying WSO2 Integrator...'
oc delete -f integrator-route.yaml
oc delete -f integrator-gateway-service.yaml
oc delete -f integrator-service.yaml
oc delete -f integrator-deployment.yaml

# databases
echoBold 'Un-deploying WSO2 Integrator Databases...'
oc delete -f mysql-service.json
oc delete -f mysql-deployment.json
oc delete -f mysql-volume.yaml

# configuration maps
#echoBold 'Deleting Configuration Maps...'
#oc delete configmap integrator-conf
#oc delete configmap integrator-conf-axis2
#oc delete configmap integrator-conf-datasources
#oc delete configmap integrator-conf-security

echoBold 'Finished'
