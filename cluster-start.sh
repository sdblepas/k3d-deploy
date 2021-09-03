#!/usr/bin/env bash
########################################################################################
# Script Name: cluster-start.sh
# Description: install k3d, kubectl and fully functional k3d cluster 
#       input: none
#      output: none
# Author: Benjamin Elharrar
# date:   02/09/2021
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

log 'Installing required app'
log 'k3d install'
wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash >> log
log 'Installing required app'
log 'kubectl install'
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" >> log
chmod +x kubectl >> log
if [ "$(id -u)" != "0" ]; then 
	echo "enter the sudo password, please"
	read PW
	echo $PW | sudo mv kubectl /usr/local/bin >> log
else
	mv kubectl /usr/local/bin >> log
fi

log 'creating cluster'
k3d cluster create --config myk3dcluster.yaml >> log
#this part is for bug https://github.com/rancher/k3d/issues/681 should be remove eventually
LIST=$(kubectl get nodes | grep none | awk '{print $1}')
for node in $LIST
do
	kubectl label nodes $node kubernetes.io/role=agent >> log
done

kubectl config view >> log

