# k3d-deploy
simple k3d install and deploy script with a basic app
the app is a fork of https://github.com/sdblepas/docker-flask-postgres 
## cluster-start.sh
this script will install k3d, kubectl and fully functional k3d cluster
after cloning do 
```chmod +x cluster-start.sh```
```chmod +x app-deploy.sh```

run ./cluster-start.sh
It will build cluster with 2 agents and 1 master
It will use the config file myk3dcluster.yaml
run ./app-deploy.sh
It will deploy a postgresql DB and a Flask web service


