#!/usr/bin/env bash

#INSTALAR ANTES DE EJECUTAR
#* docker --version
#* sudo apt-get install docker
#* sudo apt install docker.io

rm -rf tianos
sudo chmod 0777 -R data/
docker stop tianos-container
docker rm tianos-container

echo "clonando repositorio..."
#chmod 0600 common/jafeth-xalok.rsa
#git clone http://gitlab.ec.pe/jafeth.bendezu/tianos.git

docker build -t tianos-image .