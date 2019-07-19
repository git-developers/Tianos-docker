#!/usr/bin/env bash

#INSTALAR ANTES DE EJECUTAR
#* docker --version
#* sudo apt-get install docker
#* sudo apt install docker.io

rm -rf shoes-erp
sudo chmod 0777 -R data/
docker stop shoes-erp-container
docker rm shoes-erp-container

echo "clonando repositorio..."
#chmod 0600 common/jafeth-xalok.rsa
#git clone http://gitlab.ec.pe/jafeth.bendezu/shoes-erp.git

docker build -t shoes-erp-image .