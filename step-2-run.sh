#!/usr/bin/env bash

echo "-"
echo "Dando permisos al archivo docker.sock:"
sudo chmod 0777 /var/run/docker.sock


echo "-"
echo "Stopping container:"
docker stop shoes-erp-container --time 10
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
echo "-"
echo "-"
echo "Removing container: "
docker rm shoes-erp-container


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
#docker network rm shoes-erp-net
#docker network disconnect --force shoes-erp-net
# docker network create --subnet=172.18.0.0/16 shoes-erp-net



echo "-" # -idt
echo "Running container:"



#DOCKER RUN
#--volume $PWD/../shoes-erp:/shoes-erp/ \
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
--env MYSQL_DATABASE=shoes-erp \
--add-host shoes-erp.lo:172.17.0.2 \
--volume $PWD/../shoesErp:/shoes-erp/ \
--volume $PWD/data/mysql/:/var/lib/mysql/ \
--user "root:root" \
--name shoes-erp-container tianos-image



#docker run \
#--interactive \
#--detach \
#--tty \
#--net shoes-erp-net --ip 172.18.0.22 \
#--publish 0.0.0.0:81:80 \
#--add-host shoes-erp.lo:172.17.0.3 \
#--volume $PWD/../shoes-erp:/shoes-erp/ \
#--volume $PWD/data/mysql/:/var/lib/mysql/ \
#--user "root:root" \
#--name shoes-erp-container shoes-erp-image


#NETWORK
#docker network ls
#docker network create shoes-erp-net


echo "-"
echo "Starting services:"
docker exec -d shoes-erp-container chown -Rv mysql:root /var/run/mysqld/
docker exec -d shoes-erp-container chgrp -Rv mysql /var/run/mysqld/

docker exec -d shoes-erp-container chown -Rv mysql:mysql /var/lib/mysql
docker exec -d shoes-erp-container chgrp -Rv mysql /var/lib/mysql

docker exec -d shoes-erp-container chown -Rv mysql:mysql /etc/mysql/
docker exec -d shoes-erp-container chgrp -Rv mysql /etc/mysql/

docker exec -d shoes-erp-container service mysql start
docker exec -d shoes-erp-container service nginx start
docker exec -d shoes-erp-container service php7.1-fpm start
#docker exec -d shoes-erp-container service redis-server start
#docker exec -d shoes-erp-container service elasticsearch start
#docker exec -d shoes-erp-container service supervisor start


echo "Entrando al bash de la imagen shoes-erp:"
docker exec -i -t shoes-erp-container /bin/bash
