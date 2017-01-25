#!/bin/bash

cd /
sudo apt-get purge php.*

sudo apt-get install python-software-properties
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install -y php7.1 php7.1-dev php7.1-soap php7.1-xml php7.1-zip php7.1-gd php7.1-mysql php7.1-curl php7.1-mbstring php7.1-bcmath

sudo apt-get install php-pear
sudo pecl install apcu

sudo apt-get autoremove
sudo apt-get autoclean
