#!/usr/bin/env bash

echo "-"
echo "Dando permisos al archivo docker.sock:"
sudo chmod 0777 /var/run/docker.sock


echo "-"
echo "Stopping container:"
docker stop tianos-container --time 10
echo "-"
echo "Removing container: "
docker rm tianos-container


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
#docker network rm tianos-net
#docker network disconnect --force tianos-net
# docker network create --subnet=172.18.0.0/16 tianos-net



echo "-" # -idt
echo "Running container:"



#DOCKER RUN
#--volume $PWD/../tianos:/tianos/ \
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
--env MYSQL_DATABASE=tianos \
--add-host tianos.lo:172.17.0.2 \
--volume $PWD/../Tianos:/tianos/ \
--volume $PWD/data/mysql/:/var/lib/mysql/ \
--user "root:root" \
--name tianos-container tianos-image



#docker run \
#--interactive \
#--detach \
#--tty \
#--net tianos-net --ip 172.18.0.22 \
#--publish 0.0.0.0:81:80 \
#--add-host tianos.lo:172.17.0.3 \
#--volume $PWD/../tianos:/tianos/ \
#--volume $PWD/data/mysql/:/var/lib/mysql/ \
#--user "root:root" \
#--name tianos-container tianos-image


#NETWORK
#docker network ls
#docker network create tianos-net


echo "-"
echo "Starting services:"
docker exec -d tianos-container chown -Rv mysql:root /var/run/mysqld/
docker exec -d tianos-container chgrp -Rv mysql /var/run/mysqld/

docker exec -d tianos-container chown -Rv mysql:mysql /var/lib/mysql
docker exec -d tianos-container chgrp -Rv mysql /var/lib/mysql

docker exec -d tianos-container chown -Rv mysql:mysql /etc/mysql/
docker exec -d tianos-container chgrp -Rv mysql /etc/mysql/

docker exec -d tianos-container service mysql start
docker exec -d tianos-container service nginx start
docker exec -d tianos-container service php7.1-fpm start
#docker exec -d tianos-container service redis-server start
#docker exec -d tianos-container service elasticsearch start
#docker exec -d tianos-container service supervisor start


echo "Entrando al bash de la imagen tianos:"
docker exec -i -t tianos-container /bin/bash
