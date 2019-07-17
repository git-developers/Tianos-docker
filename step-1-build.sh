#!/usr/bin/env bash

#INSTALAR ANTES DE EJECUTAR
#* docker --version
#* sudo apt-get install docker
#* sudo apt install docker.io

rm -rf manguitos
sudo chmod 0777 -R data/
docker stop manguitos-container
docker rm manguitos-container

echo "clonando repositorio..."
#chmod 0600 common/jafeth-xalok.rsa
#git clone http://gitlab.ec.pe/jafeth.bendezu/manguitos.git

docker build -t manguitos-image .