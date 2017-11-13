# WSO2 Enterprise Integrator Openshift/Kubernetes Resources 
*Openshift Resources for container-based deployments of WSO2 Enterprise Integrator (EI)*

This initial version of openshift-ei contains partys from the project kubernetes-ei and that contains the deployment of a "scalable" unit of WSO2 EI integrator profile, 
running on <br> top of `Openshift/Kubernetes` with `Docker` and `MySQL` support.
 
## Quick Start Guide

>In the context of this document, `KUBERNETES_HOME` will refer to a local copy of 
[`wso2/kubernetes-ei`](https://github.com/wso2/kubernetes-ei/) git repository and you have to have git, docker and Openshift client (or Minishift) installed in your local machine to execute following steps.

##### 1. Checkout WSO2 branch openshift-ei repository using `git clone`:
```
git clone https://github.com/agentelinux/openshift-ei.git
```

##### 2. Pull required Docker images from [`WSO2 Docker Registry`](https://docker.wso2.com) using `docker pull`:
```
eval $(minishift docker-env)

docker pull ubuntu:17.04
docker pull mysql:5.7.20

```

##### 4. Deploy Openshift Resources:
Change directory to `KUBERNETES_HOME/pattern-1` and run `deploy.sh` shell script on the terminal.
```
./deploy.sh
```
>To un-deploy, be on the same directory and run `undeploy.sh` shell script on the terminal.

##### 5. Access Management Console:
Default deployment will expose two publicly accessible hosts, namely: <br>
1. `wso2ei-pattern1-integrator` - To expose Administrative services and Management Console <br>
2. `wso2ei-pattern1-integrator-gateway` - To expose Mediation Gateway <br>

To access the console in a test environment, add the above two hosts as entries in /etc/hosts file, pointing to <br> 
one of your kubernetes cluster node IPs and try navigating to `https://wso2ei-pattern1-integrator/carbon` from <br>
your favorite browser.

##### 6. How to scale using `Openshift scale`:
Default deployment runs only one replica (or pod) of WSO2 EI integrator profile. To scale this deployment into <br>
any `<n>` number of container replicas, necessary to suite your requirement, simply run following kubectl 
command on the terminal. Assuming your current working directory is `KUBERNETES_HOME/pattern-1` 
```
oc scale --replicas=<n> -f integrator-deployment.yaml
```
For example, If `<n>` is 3, you are here scaling up this deployment from 1 to 3 container replicas.


ToDO
-- adapter build KUBERNETES_HOME/dockerfiles/analytics


Removed (features of the Openshift)
-- KUBERNETES_HOME/pattern-1/integrator-ingress.yaml
-- KUBERNETES_HOME/pattern-1/nginx-default-backend.yaml
-- KUBERNETES_HOME/pattern-1/nginx-ingress-controller.yaml
