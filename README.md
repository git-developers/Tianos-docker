<h1 align="center">
    <a href="#">
        <img src="https://goto.docker.com/rs/929-FJL-178/images/Docker%20Horizontal%20Large.png" />
    </a>
</h1>


Docker Tianos
==========


[![Packagist](https://img.shields.io/packagist/v/yii2-starter-kit/yii2-starter-kit.svg)](https://packagist.org/packages/yii2-starter-kit/yii2-starter-kit)
[![Packagist](https://img.shields.io/packagist/dt/yii2-starter-kit/yii2-starter-kit.svg)](https://packagist.org/packages/yii2-starter-kit/yii2-starter-kit)
[![Build Status](https://travis-ci.org/yii2-starter-kit/yii2-starter-kit.svg?branch=master)](https://travis-ci.org/yii2-starter-kit/yii2-starter-kit)



How to create Docker Images with a Dockerfile

* Introduction to the Dockerfile Command.
* Step 1 - Installing Docker.
* Step 2 - Create Dockerfile.
* Step 3 - Build New Docker Image and Create New Container Based on it.
* Step 4 - Testing Nginx and PHP-FPM in the Container.
* Reference.


mysql
======
* .sock


```php
/var/run/mysqld/mysqld.sock
```

DOCKER 
======
* -p, --publish :: Publish a container's port(s) to the host (default [])
* -v, --volume :: Bind mount a volume (default [])
* --hostname to specify a hostname
* --add-host to add more entries to /etc/hosts
* .
* To list all containers on your system using ps option, but ps will show only running containers. So to view all containers use -a parameter with ps.
    * docker ps -a
* To find all images on your system
    * docker images
* Crear container, aunque ya exista
    * docker run -it --rm xalok
* Remove Docker Containers
    * docker rm <CONTAINER ID>
* Remove Docker Images
    * docker rmi <IMAGE ID> --force
* Stop & Remove All Docker Containers
    * docker stop $(docker ps -a -q)
    * docker rm $(docker ps -a -q)
    * docker stop $(docker ps -a -q); docker rm $(docker ps -a -q);
* Stop docker
    * docker ps -a -q --filter="name=<containerName>"
    * docker ps -a -q --filter="name=xalok"
* How to delete cache?
    * docker system prune -a
* Tag
    * docker tag <IMAGE ID> <NOMBRE>:<VERSION>
    * docker tag 9f676bd305a4 ubuntu:13.10
* Listar volumes
    * docker volume ls ##lista volumes
    * docker volume rm <volume_name> ##elimina volumes
* Dentro del docker, ver volumes
    * df -h
* Info del docker
    * docker -D info
* docker version
    * docker version
* Logs
    * docker logs <CONTAINER_ID>
* Deleting the networking files fixes it for me
    *   rm -rf /var/lib/docker/network/files/*

