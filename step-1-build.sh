#!/usr/bin/env bash

#INSTALAR ANTES DE EJECUTAR
#* docker --version
#* sudo apt-get install docker
#* sudo apt install docker.io

rm -rf e-commerce
sudo chmod 0777 -R data/
docker stop e-commerce-container
docker rm e-commerce-container

echo "clonando repositorio..."
#chmod 0600 common/jafeth-xalok.rsa
#git clone http://gitlab.ec.pe/jafeth.bendezu/e-commerce.git

docker build -t e-commerce-image .