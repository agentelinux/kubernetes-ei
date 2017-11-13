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

set -e

# Product Info
product=wso2ei
productVersion=6.1.1
profile=integrator
# Container Cluster Manager Info
platform=kubernetes
# Image Info
repository=openshift/${product}-${platform}-${profile}
tag=${productVersion}

echo "Creating ${repository}:${tag}..."
docker build -t ${repository}:${tag} .
docker images --filter "dangling=true" -q --no-trunc | xargs docker rmi > /dev/null 2>&1
