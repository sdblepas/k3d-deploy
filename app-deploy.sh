#!/usr/bin/env bash
########################################################################################
# Script Name: app-deploy.sh
# Description: deploy DB and flask app to created cluster
#       input: none
#      output: none
# Author: Benjamin Elharrar
# date:   17/09/2021
# Code review: Saar/David
#
########################################################################################

########################################
# log()
########################################
log(){
                echo $(date +%Y%m%d.%H%M%S)': '$1 >> $LOGFILE
}

# TIMESTAMP
TIMESTAMP=$(date +%Y%m%d.%H%M%S)
# log file
LOGFILE=log_$TIMESTAMP.txt

kubectl create -f env-configmap.yaml >> log
kubectl create -f web-claim0-persistentvolumeclaim.yaml >> log
kubectl apply -f  db-deployment.yaml >> log
kubectl apply -f  web-deployment.yaml >> log
kubectl apply -f web-svc.yaml

