#!/bin/bash

if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi

${SUDO} systemctl restart php7.2-fpm
${SUDO} mkdir /var/www/vhosts
${SUDO} mkdir /var/www/vhosts/pixelfed
${SUDO} mkdir /var/www/vhosts/pixelfed/httpdocs
${SUDO} mkdir /var/www/vhosts/pixelfed/logs
${SUDO} git clone https://github.com/dansup/pixelfed.git /var/www/vhosts/pixelfed/httpdocs
${SUDO} chown anartist:anartist /var/www/vhosts/pixelfed/httpdocs/ -R
${SUDO} apt install zip unzip
cd /var/www/vhosts/pixelfed/httpdocs && composer install
cp /var/www/vhosts/pixelfed/httpdocs/.env.example /var/www/vhosts/pixelfed/httpdocs/.env
echo "Edit /var/www/vhosts/pixelfed/httpdocs/.env"



