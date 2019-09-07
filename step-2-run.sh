#!/usr/bin/env bash

echo "-"
echo "Dando permisos al archivo docker.sock:"
sudo chmod 0777 /var/run/docker.sock


echo "-"
echo "Stopping container:"
docker stop koketa-container --time 10
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
echo "-"
echo "-"
echo "Removing container: "
docker rm koketa-container


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
#docker network rm koketa-net
#docker network disconnect --force koketa-net
# docker network create --subnet=172.18.0.0/16 koketa-net



echo "-" # -idt
echo "Running container:"



#DOCKER RUN
#--volume $PWD/../Koketa:/koketa/ \
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
--env MYSQL_DATABASE=koketa \
--add-host koketa.lo:172.17.0.2 \
--volume $PWD/../Koketa:/koketa/ \
--volume $PWD/data/mysql/:/var/lib/mysql/ \
--user "root:root" \
--name koketa-container tianos-image



#docker run \
#--interactive \
#--detach \
#--tty \
#--net koketa-net --ip 172.18.0.22 \
#--publish 0.0.0.0:81:80 \
#--add-host koketa.lo:172.17.0.3 \
#--volume $PWD/../Koketa:/koketa/ \
#--volume $PWD/data/mysql/:/var/lib/mysql/ \
#--user "root:root" \
#--name koketa-container koketa-image


#NETWORK
#docker network ls
#docker network create koketa-net


echo "-"
echo "Starting services:"
docker exec -d koketa-container chown -Rv mysql:root /var/run/mysqld/
docker exec -d koketa-container chgrp -Rv mysql /var/run/mysqld/

docker exec -d koketa-container chown -Rv mysql:mysql /var/lib/mysql
docker exec -d koketa-container chgrp -Rv mysql /var/lib/mysql

docker exec -d koketa-container chown -Rv mysql:mysql /etc/mysql/
docker exec -d koketa-container chgrp -Rv mysql /etc/mysql/

docker exec -d koketa-container service mysql start
docker exec -d koketa-container service nginx start
docker exec -d koketa-container service php7.1-fpm start
#docker exec -d koketa-container service redis-server start
#docker exec -d koketa-container service elasticsearch start
#docker exec -d koketa-container service supervisor start


echo "Entrando al bash de la imagen koketa:"
docker exec -i -t koketa-container /bin/bash
