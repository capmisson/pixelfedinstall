#!/bin/bash

if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi

make_password () {
    PASS=`< /dev/urandom tr -dc A-Za-z0-9 | head -c28;`
}

# Continue installing pixelfed into vhost
cd /var/www/vhosts/pixelfed && php artisan key:generate
cd /var/www/vhosts/pixelfed && php artisan storage:link
cd






