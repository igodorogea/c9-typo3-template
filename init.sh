#!/bin/bash

function say {
    printf "\n--------------------------------------------------------\n"
    printf "\t$1"
    printf "\n--------------------------------------------------------\n"
}

say "Prepare machine..."

say "start db"
mysql-ctl start

say "remove existing php"
cd /
sudo apt-get purge -y `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "`

say "install php 7.1"
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update
sudo apt-get install -y php7.1 php7.1-dev php7.1-soap php7.1-xml php7.1-zip php7.1-gd php7.1-mysql php7.1-curl php7.1-mbstring php7.1-bcmath php-pear
sudo pecl install apcu

say "Install imagemagick"
sudo apt-get install -y imagemagick php-imagick

sudo apt-get autoremove -y
sudo apt-get autoclean -y

say "update vhost"
sudo sed -i 's/\/home\/ubuntu\/workspace$/\/home\/ubuntu\/workspace\/web/' /etc/apache2/sites-available/001-cloud9.conf
sudo sed -i 's/\/home\/ubuntu\/workspace>$/\/home\/ubuntu\/workspace\/web>/' /etc/apache2/sites-available/001-cloud9.conf

say "Install dependencies"
cd ~/workspace
composer install

say "Setup typo3"
./vendor/bin/typo3cms install:setup --non-interactive --database-user-name="root" --database-name="typo3_demo" --admin-user-name="admin" --admin-password="password" --site-name="Auto Install"

say "Done."
                
# ./vendor/bin/typo3cms database:updateschema '*.*'
# ./vendor/bin/typo3cms extension:activate bootstrap_package
# ./vendor/bin/typo3cms extension:activate introduction