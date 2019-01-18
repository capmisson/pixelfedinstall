# Pixelfed Installation Instructions with script

Alpha instructions for installation of Pixelfed with Scripts

  - sudo apt install git
  - git clone https://github.com/capmisson/pixelfedinstall 
  - bash script1.sh
  - Edit /etc/php/7.2/fpm/pool.d/pixelfed.conf and change pixelfed username and group for your username and group
  - bash script2.sh
  - Edit /var/www/vhosts/pixelfed/httpdocs/.env and change:
  - APP_URL=http://localhost -> change localhost to your domain name
  - ADMIN_DOMAIN="localhost" -> change localhost to your domain name
  - APP_DOMAIN="localhost" -> change localhost to your domain name
 - bash script3.sh
 
    
```sh
$ screen
$ php artisan horizon
$ ctrl + a + d
```
