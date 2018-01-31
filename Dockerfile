############################################################
# Dockerfile to build Tianos container images
# Based on Ubuntu
############################################################


FROM ubuntu:16.04
MAINTAINER authors_jafeth
#RUN apt-get update --fix-missing
RUN apt-get update --fix-missing

# Set the locale
#RUN locale-gen en_US.UTF-8
#RUN LC_ALL=C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL C.UTF-8
#ENV LC_ALL en_US.UTF-8

# Install dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y


################## BEGIN INSTALLATION ######################

RUN apt-get install -y build-essential
RUN apt-get install -y software-properties-common
RUN apt-get install -y python-software-properties

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update -y

RUN apt-get -y install php7.1
RUN apt-get -y install php7.1-fpm
RUN apt-get -y install php7.1-mysql
RUN apt-get -y install php7.1-curl
RUN apt-get -y install php7.1-mcrypt
RUN apt-get -y install php7.1-cli
RUN apt-get -y install php7.1-dev
RUN apt-get -y install php7.1-intl
RUN apt-get -y install libsasl2-dev
RUN apt-get -y install redis-server
#RUN apt-get -y install openjdk-8-jre
RUN apt-get -y install wget
RUN apt-get -y install curl
RUN apt-get -y install git
RUN apt-get -y install curl
RUN apt-get -y install ssh
RUN apt-get -y install libicu-dev
RUN apt-get -y install nginx
RUN apt-get -y install build-essential
RUN apt-get -y install phpunit
RUN apt-get -y install php-mbstring


### para instalar MYSQL
RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
RUN apt-get -q -y install mysql-server


#URL: https://eole-io.github.io/sandstone/install-zmq-php-linux.html
## Install ZeroMQ
RUN apt-get -y install libtool
RUN apt-get -y install autoconf
RUN apt-get -y install uuid-dev
RUN apt-get -y install libsodium-dev
RUN apt-get -y install php-pear
RUN apt-get -y install pkg-config
RUN apt-get -y install libzmq-dev
RUN yes '' | pecl install zmq-beta
RUN wget --directory-prefix /home https://archive.org/download/zeromq_4.1.4/zeromq-4.1.4.tar.gz # Latest tarball on 07/08/2016
RUN tar -xvzf /home/zeromq-4.1.4.tar.gz -C /home
RUN cd /home/zeromq-4.1.4; ./configure
RUN cd /home/zeromq-4.1.4/; make
RUN cd /home/zeromq-4.1.4; make install
RUN cd /home/zeromq-4.1.4; ldconfig
## Install ZeroMQ


## Installing the PHP binding
RUN mkdir -p /home/php-zmq
RUN git clone https://github.com/mkoppanen/php-zmq.git /home/php-zmq
RUN cd /home/php-zmq; phpize && ./configure
RUN cd /home/php-zmq; make
RUN cd /home/php-zmq; make install
## Installing the PHP binding


## extension=zmq.so
#RUN touch /etc/php/7.0/mods-available/zmq.ini
#RUN echo 'extension=zmq.so' >> /etc/php/7.0/mods-available/zmq.ini
#RUN phpenmod zmq


### composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


### extras
RUN apt-get -y install acl
RUN apt-get -y install make
RUN apt-get -y install vim
RUN apt-get -y install nano
RUN apt-get -y install iputils-ping
RUN apt-get -y install lynx
RUN apt-get -y install net-tools #para utilizar el route command


##################### INSTALLATION END #####################
RUN mkdir /tianos/
RUN mkdir /root/.ssh
#VOLUME ["../tianos"] #The VOLUME command is used to enable access from your container to a directory on the host machine
#CMD ["php7.1-fpm"]

