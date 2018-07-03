# Vagrant Docker EE

## Description

2 files must be provided in the private-conf sub folder
see "My Content section" at https://store.docker.com 
- docker_subscription.lic (download License Key)
- docker_private_repo.txt (https://storebits.docker.com/ee/ubuntu/sub-XXXXXXX)

Contient la configuration Vagrant réalisant le provising des VM VirtualBox et la configuration du cluster Docker EE
La configuration de l'ensemble du cluster est réalisée dans un unique fichier Vagrantfile (avec une boucle pour les machines nodeX):

- master
- node1
- node2


# UCP 
L'initialisation du cluster est piloté par le Vagrant file

Vagrant initialise un répertoire partagé avec le host au niveau de chaque machine dans le répertoire /vagrant
Ce répertoire partagé est utilisé pour partager le swarm-join-token entre le master et les nodeX.
Le token swarm est écrit dans le fichier /vagrant/generated-conf/swarm-join-token, utilisé par les nodeX pour s'enregistrer sur le cluster.

le script setup-master installe UCP et DTR

## accès à la console d'admin UCP
https://192.169.33.10
user : admin
pass : admin1234

## DTR Docker Trusted Registry
https://192.169.33.10:9443

# docker-demo

## exemple de creation de service (SWARM)
Un service [docker-demo](https://github.com/ehazlett/docker-demo) est créé avec replicas à 2
```docker service create -p 8080:8080 --detach=false --replicas=2 --name docker-demo -e SHOW_VERSION=true -e VERSION=1.0 -e TITLE=DockerEE ehazlett/docker-demo:latest```
Une fois lancée, l'application sera accessible via le port 8080 sur toutes les machines du cluster (même celle qui ne font par tourner le conteneur):
 - http://192.169.33.10:8080
 - http://192.169.33.11:8080
 - http://192.169.33.12:8080


## Test du service docker-demo


### scaling du service

```docker service scale docker-demo=4```

### scaling du service

```docker service scale docker-demo=4```

### Détail du service

```docker service inspect docker-demo --pretty```

```docker service ps docker-demo```

### Update du service

```docker service update --env-add VERSION=2.0 docker-demo```


### forcer le rescheduling
Après le démarrage d'un noeud, il faut forcer un re-scheduling pour qu'il se voit attributer des conteneurs

```docker service update --force docker-demo```
