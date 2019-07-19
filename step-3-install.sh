#!/usr/bin/env bash

cd /shoes-erp/
#se ingresa al folder shoes-erp/ y se ejecuta ese .sh

#service elasticsearch start
#service mysql start
service nginx restart
service php7.0-fpm start
#service redis-server start
#service elasticsearch start
#service supervisor start
echo "127.0.0.1 shoes-erp.lo" >> /etc/hosts
#npm config set loglevel info
composer install