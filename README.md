# pixelfedinstall
Installation instructions for Pixelfed
bash script1.sh
Edit /etc/php/7.2/fpm/pool.d/pixelfed.conf and change pixelfed username and group for your username and group
bash script2.sh
Edit /var/www/vhosts/pixelfed/httpdocs/.env and edit:
APP_URL=http://localhost -> yourdomain
ADMIN_DOMAIN="localhost" -> yourdomain
APP_DOMAIN="localhost" -> yourdomain
bash script3.sh
