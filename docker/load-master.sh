#!/bin/bash

cd /var/www/html/open-orchestra-master/open-orchestra

mkdir -p /var/app/open-orchestra-master/open-orchestra/cache
mkdir -p /var/app/open-orchestra-master/open-orchestra/logs
mkdir -p /var/app/open-orchestra-master/open-orchestra-front-demo/cache
mkdir -p /var/app/open-orchestra-master/open-orchestra-front-demo/logs
mkdir -p /var/app/open-orchestra-master/open-orchestra-media-demo/cache
mkdir -p /var/app/open-orchestra-master/open-orchestra-media-demo/logs

rm -rf /var/app/open-orchestra-master/open-orchestra/cache/*
rm -rf /var/app/open-orchestra-master/open-orchestra/logs/*
rm -rf /var/app/open-orchestra-master/open-orchestra-front-demo/cache/*
rm -rf /var/app/open-orchestra-master/open-orchestra-front-demo/logs/*
rm -rf /var/app/open-orchestra-master/open-orchestra-media-demo/cache/*
rm -rf /var/app/open-orchestra-master/open-orchestra-media-demo/logs/*

ln -sf /var/app/open-orchestra-master/open-orchestra/cache /var/www/html/open-orchestra-master/open-orchestra/app/cache
ln -sf /var/app/open-orchestra-master/open-orchestra/logs /var/www/html/open-orchestra-master/open-orchestra/app/logs
chmod -R 777 /var/app

npm install
composer install

cd open-orchestra-master/open-orchestra/
php app/console orchestra:mongodb:fixtures:load --type=all --env=prod
php app/console orchestra:elastica:index:create
php app/console orchestra:elastica:schema:create
php app/console orchestra:elastica:populate

chmod -R 777 /var/app

./bin/grunt