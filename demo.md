# Container Orchestration Demo Cluster init with Vagrant

## Docker CE

```
docker container run -d -e "TITLE=Docker CE - DEV" -p 8080:80 dmaumenee/docker-demo

docker network create demo-rec
docker container run -d -e "TITLE=Docker CE - REC" -p 8081:80 dmaumenee/docker-demo

```

## Docker EE

```
import stack C:\projets\transverse\container-orchestration-demo\dockerEE\demo\dockercoins-stack.yml
```
Load Balancer webui-published