# Container Orchestration Demo Cluster init with Vagrant

## ehazlett/docker-demo

```
TITLE=AKS Rancher 2
SHOW_VERSION=true
VERSION=1.0
REFRESH_INTERVAL=250
```

```
wget -qO- http://docker-demo:8080/ping
```

## Docker CE

```
docker container run -d -e "TITLE=Docker CE - DEV" -p 8080:80 dmaumenee/docker-demo

docker network create demo-rec
docker container run -d -e "TITLE=Docker CE - REC" --network demo-rec -p 8081:80 dmaumenee/docker-demo

```

## Kubernetes

### accès au dashboard


## OpenShift

### Console Web

#### Catalogue
Browse Catalogue

#### Deploiment
Création d'un projet live-demo
docker-demo via IHM

### CLI
Ouvrir la console web et se mettre dans le projet après sa création

```
cd C:\projets\transverse\container-orchestration-demo-meetup
ls
oc login -u developer
oc projects
oc delete project live-demo-cli
oc new-project live-demo-cli
oc create -f docker-demo-dc.yaml
oc get all
oc create -f docker-demo-svc.yaml
oc get all
oc expose service docker-demo
oc get all

curl http://docker-demo-live-demo-cli.192.168.99.100.nip.io/ping
```


## Docker EE

### browse API

### import swarm stack en deploy to K8s
```
import stack C:\projets\transverse\container-orchestration-demo\dockerEE\demo\dockercoins-stack.yml
```
Load Balancer webui-published

### DTR
```
docker login
david
password123

docker pull dmaumenee/docker-demo
docker tag dmaumenee/docker-demo 192.169.33.10:9443/orga-one/docker-demo:1
docker push 192.169.33.10:9443/orga-one/docker-demo:1

```

Se connecter à la VM docker-ce


## Rancher2

ipconfig /flushdns

### show API

### Création de projet 
- Création d'un projet avec quota
- Création d'un namespace
- Création d'un user avec droit custom
- Connexion avec user live-demo

### Deploy app
- deploy via IHM
- deploy via Yaml
- scaling limité par quotas

### Pipeline
