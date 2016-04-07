#!/bin/bash

mkdir -p /var/app/open-orchestra-stable/open-orchestra/cache
mkdir -p /var/app/open-orchestra-stable/open-orchestra/logs
mkdir -p /var/app/open-orchestra-stable/open-orchestra-front-demo/cache
mkdir -p /var/app/open-orchestra-stable/open-orchestra-front-demo/logs
mkdir -p /var/app/open-orchestra-stable/open-orchestra-media-demo/cache
mkdir -p /var/app/open-orchestra-stable/open-orchestra-media-demo/logs

rm -rf /var/app/open-orchestra-stable/open-orchestra/cache/*
rm -rf /var/app/open-orchestra-stable/open-orchestra/logs/*
rm -rf /var/app/open-orchestra-stable/open-orchestra-front-demo/cache/*
rm -rf /var/app/open-orchestra-stable/open-orchestra-front-demo/logs/*
rm -rf /var/app/open-orchestra-stable/open-orchestra-media-demo/cache/*
rm -rf /var/app/open-orchestra-stable/open-orchestra-media-demo/logs/*

ln -sf /var/app/open-orchestra-stable/open-orchestra/cache /var/www/html/open-orchestra-stable/open-orchestra/app/cache
ln -sf /var/app/open-orchestra-stable/open-orchestra/logs /var/www/html/open-orchestra-stable/open-orchestra/app/logs
ln -sf /var/app/open-orchestra-stable/open-orchestra/cache /var/www/html/open-orchestra-stable/open-orchestra-front-demo/app/cache
ln -sf /var/app/open-orchestra-stable/open-orchestra/logs /var/www/html/open-orchestra-stable/open-orchestra-front-demo/app/logs
ln -sf /var/app/open-orchestra-stable/open-orchestra/cache /var/www/html/open-orchestra-stable/open-orchestra-media-demo/app/cache
ln -sf /var/app/open-orchestra-stable/open-orchestra/logs /var/www/html/open-orchestra-stable/open-orchestra-media-demo/app/logs

cd /var/www/html/open-orchestra-stable/open-orchestra
npm install
composer install

php app/console orchestra:mongodb:fixtures:load --type=all --env=prod
php app/console orchestra:elastica:index:create
php app/console orchestra:elastica:schema:create
php app/console orchestra:elastica:populate

./bin/grunt

cd /var/www/html/open-orchestra-stable/open-orchestra-front-demo
composer install

cd /var/www/html/open-orchestra-stable/open-orchestra-media-demo
composer install

chmod -R 777 /var/app
chmod -R 777 /var/uploaded-files

