#!/usr/bin/env bash

echo "-"
echo "Dando permisos al archivo docker.sock:"
sudo chmod 0777 /var/run/docker.sock


echo "-"
echo "Stopping container:"
docker stop e-commerce-container --time 10
echo "-"
echo "Removing container: "
docker rm e-commerce-container


echo "-"
echo "Eliminando, creando y dando permisos a carpetas DATA:"
if [ $# -gt 0 ]; then
    if [ "$1" == "data" ]; then
        sudo rm -rf data
        mkdir -p -v $PWD/data/elasticsearch $PWD/data/redis $PWD/data/mysql/
#        sudo chmod 0777 -R data/
    else
        echo "INFO: Para gestionar el folder, enviar el argumento. 'data' "
    fi
else
    echo "INFO: No se envio argumentos: para gestionar el folder 'data' "
fi


#Stop & Remove All Docker Containers
#docker stop $(docker ps -a -q); docker rm $(docker ps -a -q);


# para poder ejecutar la opcion "--net", primero se tiene que ejecutar la linea de abajo
#docker network rm e-commerce-net
#docker network disconnect --force e-commerce-net
# docker network create --subnet=172.18.0.0/16 e-commerce-net



echo "-" # -idt
echo "Running container:"



#DOCKER RUN
#--volume $PWD/../e-commerce:/e-commerce/ \
#HOST -> GUEST

echo "-" # -idt
#--privileged \
echo "Running container:"

docker run \
--interactive \
--detach \
--tty \
--publish 0.0.0.0:1234:3306 \
--env MYSQL_ROOT_PASSWORD=root \
--env MYSQL_DATABASE=e-commerce \
--add-host e-commerce.lo:172.17.0.2 \
--volume $PWD/../shoesErp:/e-commerce/ \
--volume $PWD/data/mysql/:/var/lib/mysql/ \
--user "root:root" \
--name e-commerce-container tianos-image



#docker run \
#--interactive \
#--detach \
#--tty \
#--net e-commerce-net --ip 172.18.0.22 \
#--publish 0.0.0.0:81:80 \
#--add-host e-commerce.lo:172.17.0.3 \
#--volume $PWD/../e-commerce:/e-commerce/ \
#--volume $PWD/data/mysql/:/var/lib/mysql/ \
#--user "root:root" \
#--name e-commerce-container e-commerce-image


#NETWORK
#docker network ls
#docker network create e-commerce-net


echo "-"
echo "Starting services:"
docker exec -d e-commerce-container chown -Rv mysql:root /var/run/mysqld/
docker exec -d e-commerce-container chgrp -Rv mysql /var/run/mysqld/

docker exec -d e-commerce-container chown -Rv mysql:mysql /var/lib/mysql
docker exec -d e-commerce-container chgrp -Rv mysql /var/lib/mysql

docker exec -d e-commerce-container chown -Rv mysql:mysql /etc/mysql/
docker exec -d e-commerce-container chgrp -Rv mysql /etc/mysql/

docker exec -d e-commerce-container service mysql start
docker exec -d e-commerce-container service nginx start
docker exec -d e-commerce-container service php7.1-fpm start
#docker exec -d e-commerce-container service redis-server start
#docker exec -d e-commerce-container service elasticsearch start
#docker exec -d e-commerce-container service supervisor start


echo "Entrando al bash de la imagen e-commerce:"
docker exec -i -t e-commerce-container /bin/bash
