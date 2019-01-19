# Pixelfed Installation Instructions with script

Alpha instructions for installation of Pixelfed with Scripts

1. Install Git + Download Scripts
```sh
$ sudo apt install git
$ git clone https://github.com/capmisson/pixelfedinstall
$ cd pixelfedinstall
$ bash script1.sh
```

Edit /var/www/vhosts/pixelfed/.env and change:
```sh
APP_URL=http://localhost -> change localhost to your domain name
ADMIN_DOMAIN="localhost" -> change localhost to your domain name
APP_DOMAIN="localhost" -> change localhost to your domain name
```

Execute 2nd Script 
```sh
$ bash script2.sh
```

Create pixelfed database user and database

```sh
cd /tmp
wget https://dev.mysql.com/get/mysql-apt-config_0.8.11-1_all.deb
sudo dpkg -i mysql-apt-config* 
sudo apt update 
sudo apt-get install mysql-server mysql-client mysql-common -y
sudo systemctl status mysql 
mysql_secure_installation 

mysql -u root -p 


CREATE USER 'pixelfed'@'localhost' IDENTIFIED BY 'password'; 
CREATE DATABASE pixelfed; 
GRANT ALL PRIVILEGES ON pixelfed.* TO 'pixelfed'@'localhost'; 
FLUSH PRIVILEGES;  
exit
```

Edit .env
```sh
DB_CONNECTION=mysql
DB_DATABASE=pixelfed
DB_username=pixelfed
DB_PASSWORD=password
DB_PORT=3306
```

Migrate DB
```sh
cd /var/www/vhosts/pixelfed && php artisan migrate
```

Install screen
```sh
${SUDO} apt install screen
```

Execute screen and Horizon
```sh
screen
sudo -u www-data php artisan horizon
```

Leave screen on background (ctrl + a + d)
```sh
$ sudo nano /etc/nginx/sites-available/example.com.conf

```

Edit the nginx config file as https://github.com/capmisson/pixelfedinstall/blob/master/example.conf

```sh
$ sudo ln -s /etc/nginx/sites-available/example.com.conf /etc/nginx/sites-enabled/
$ sudo service nginx reload
$ sudo nano /etc/apt/sources.list
```

Add Sources for Certbot + Stretch-Backports:
```sh
deb http://deb.debian.org/debian stretch-backports main contrib non-free
deb-src http://deb.debian.org/debian stretch-backports main contrib non-free
```

Then install certbot & stretch-backports:
```sh
$ sudo apt update
$ sudo apt install python-certbot-nginx -t stretch-backports
$ sudo certbot --nginx -d example.com -d www.example.com
```
Select the option of redirecting all transit thru https

```sh
$ sudo nano /var/www/vhosts/pixelfed/.env
```

Edit app_url to https
Edit mail smtp info ** (check end of README)
Then refresh cache as follows:
```sh
$ cd /var/www/vhosts/pixelfed
$ php artisan config:cache
```

Go to your domain, create a new user and then if you want to upgrade it to admin:
```sh
$ php artisan tinker
$ $username = 'yourusername';
$ $user = User::whereUsername($username)->first();
$ $user->is_admin = true;
$ $user->save();
$ exit
$ php artisan config:cache
$ sudo chown www-data:www-data /var/www/vhosts/pixelfed/ -R
```

** Config for Mailgun:
```sh
MAIL_DRIVER=smtp
MAIL_HOST=smtp.mailgun.org
MAIL_PORT=587 
MAIL_USERNAME=postmaster@example.com
MAIL_PASSWORD=YOURMAILGUNSMTPPASSWORD
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="pixelfed@example.com"
MAIL_FROM_NAME="Pixelfed"
```
