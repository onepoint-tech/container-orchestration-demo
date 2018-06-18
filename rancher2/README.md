# Rancher 2 avec Vagrant

## Description

Contient la configuration Vagrant réalisant le provising des VM VirtualBox et initialise le master Rancher
La configuration de l'ensemble du cluster est réalisée dans un unique fichier Vagrantfile (avec une boucle pour les machines nodeX):

- master
- node1
- node2
- node3



# Rancher
L'initialisation du master est piloté par le Vagrant file
Le noeud master est initialisé avec le script setup-master.sh
```docker run -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher:v2.0.2```
utiliser les stable ou latest suivant vos besoins

Attention dans les conteneurs, les noms de machine ne sont pas résolue dans les conteneurs donc la config de Rancher doit utiliser les IP

## IHM d'admin
URL : https://192.168.33.30

See https://rancher.com/docs/rancher/v2.x/en/quick-start-guide/