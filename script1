#!/bin/bash

if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi

${SUDO} apt-get update
${SUDO} apt-get -y install apt-transport-https lsb-release ca-certificates
${SUDO} wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
${SUDO} sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
${SUDO} apt-get update
${SUDO} wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && ${SUDO} dpkg -i erlang-solutions_1.0_all.deb
${SUDO} apt-get update
${SUDO} apt-get install -y erlang-dev erlang-xmerl erlang-parsetools elixir
${SUDO} wget -qO- https://deb.nodesource.com/setup_10.x | ${SUDO} -E bash -
${SUDO} apt-get install -y nodejs build-essential
${SUDO} apt-get update && ${SUDO} apt-get install yarn
${SUDO} apt-get install -y git htop bmon mc pngquant optipng jpegoptim gifsicle
${SUDO} apt-get install -y php7.2-fpm php7.2 php7.2-common php7.2-cli php7.2-gd php7.2-mbstring php7.2-xml php7.2-json php7.2-bcmath php7.2-pgsql php7.2-curl
${SUDO} apt-get install -y nginx redis-server postgresql
${SUDO} sed -i "s/supervised no/supervised systemd/" /etc/redis/redis.conf
${SUDO} systemctl restart redis
${SUDO} npm install -g svgo
${SUDO} apt install curl
${SUDO} curl -s https://getcomposer.org/installer | php
${SUDO} mv composer.phar /usr/local/bin/composer
${SUDO} chmod +x /usr/local/bin/composer
${SUDO} wget https://gist.github.com/carbontwelve/024c68c68605dc581474145eda74ac38#file-pixelfed-fpm-conf
${SUDO} cp ./pixelfed.fpm.conf /etc/php/7.2/fpm/pool.d/pixelfed.conf
$echo "Edit /etc/php/7.2/fpm/pool.d/pixelfed.conf and change pixelfed username and group for your username and group"

