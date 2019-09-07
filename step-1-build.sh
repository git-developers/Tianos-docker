#!/usr/bin/env bash

#INSTALAR ANTES DE EJECUTAR
#* docker --version
#* sudo apt-get install docker
#* sudo apt install docker.io

rm -rf koketa
sudo chmod 0777 -R data/
docker stop koketa-container
docker rm koketa-container

echo "clonando repositorio..."
#chmod 0600 common/jafeth-xalok.rsa
#git clone http://gitlab.ec.pe/jafeth.bendezu/koketa.git

docker build -t koketa-image .