#!/bin/bash
#Adapted from https://gist.github.com/carbontwelve/024c68c68605dc581474145eda74ac38

if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi

# Install sury.org package source
${SUDO} apt-get update
${SUDO} apt-get -y install apt-transport-https lsb-release ca-certificates
${SUDO} wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
${SUDO} sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
${SUDO} apt-get update

# Install Erlang Solutions repo
${SUDO} wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && ${SUDO} dpkg -i erlang-solutions_1.0_all.deb
${SUDO} apt-get update
# Install Elixir
${SUDO} apt-get install -y erlang-dev erlang-xmerl erlang-parsetools elixir

# Install Node.js 10.x
${SUDO} wget -qO- https://deb.nodesource.com/setup_10.x | ${SUDO} -E bash -
${SUDO} apt-get install -y nodejs build-essential

# Install Yarn
${SUDO} apt-get update && ${SUDO} apt-get install yarn

# Install htop, bmon, mc and misc tools required by pixelfed
${SUDO} apt-get install -y htop bmon mc pngquant optipng jpegoptim gifsicle

# Install PHP 7.2 FPM + additional extensions requiredd by pixelfed
${SUDO} apt-get install -y php7.2-fpm php7.2 php7.2-common php7.2-cli php7.2-gd php7.2-mbstring php7.2-xml php7.2-json php7.2-bcmath php7.2-pgsql php7.2-curl

# Install Nginx, Redis and Postgres
${SUDO} apt-get install -y nginx redis-server postgresql

# Configure Redis supervised by systemd
${SUDO} sed -i "s/supervised no/supervised systemd/" /etc/redis/redis.conf
${SUDO} systemctl restart redis

# Install svgo required by pixelfed, also curl
${SUDO} npm install -g svgo
${SUDO} apt install curl

# Install composer
${SUDO} curl -s https://getcomposer.org/installer | php
${SUDO} mv composer.phar /usr/local/bin/composer
${SUDO} chmod +x /usr/local/bin/composer

# Restart php7.2-fpm (might not be needed)
${SUDO} systemctl restart php7.2-fpm

# Create pixelfed vhost directory
${SUDO} mkdir /var/www/vhosts
${SUDO} mkdir /var/www/vhosts/pixelfed

# Install pixelfed into vhost
${SUDO} git clone https://github.com/pixelfed/pixelfed.git /var/www/vhosts/pixelfed
${SUDO} mkdir /var/www/vhosts/pixelfed/logs
${SUDO} chown $USERNAME:$GROUP /var/www/vhosts/pixelfed/ -R
${SUDO} apt install zip unzip
cd /var/www/vhosts/pixelfed && composer install
cp /var/www/vhosts/pixelfed/.env.example /var/www/vhosts/pixelfed/.env
echo "Edit /var/www/vhosts/pixelfed/.env"



