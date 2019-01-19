#!/bin/bash

if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi

make_password () {
    PASS=`< /dev/urandom tr -dc A-Za-z0-9 | head -c28;`
}

# Continue installing pixelfed into vhost
cd /var/www/vhosts/pixelfed/httpdocs && php artisan key:generate
cd /var/www/vhosts/pixelfed/httpdocs && php artisan storage:link
cd

# Create pixelfed database user and database
make_password
${SUDO} -u postgres psql --command "CREATE ROLE pixelfed PASSWORD '${PASS}' NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN"
${SUDO} -u postgres createdb -O pixelfed pixelfed

# Insert info on .env
${SUDO} sed -i "s/DB_CONNECTION=.*/DB_CONNECTION=pgsql/" /var/www/vhosts/pixelfed/httpdocs/.env
${SUDO} sed -i "s/DB_DATABASE=.*/DB_DATABASE=pixelfed/" /var/www/vhosts/pixelfed/httpdocs/.env
${SUDO} sed -i "s/DB_USERNAME=.*/DB_USERNAME=pixelfed/" /var/www/vhosts/pixelfed/httpdocs/.env
${SUDO} sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=${PASS}/" /var/www/vhosts/pixelfed/httpdocs/.env
${SUDO} sed -i "s/DB_PORT=.*/DB_PORT=5432/" /var/www/vhosts/pixelfed/httpdocs/.env
cd /var/www/vhosts/pixelfed/httpdocs && php artisan migrate

# Install screen
${SUDO} apt install screen
echo "Execute screen and php artisan horizon"




