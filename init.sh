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
sudo apt-get purge -y php.*

say "install php 7.1"
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php
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

say "Done."
