#!/bin/bash

cd /var/www/html/open-orchestra-stable/open-orchestra

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
chmod -R 777 /var/app

npm install
composer install

php app/console orchestra:mongodb:fixtures:load --type=all --env=prod

chmod -R 777 /var/app

./node_modules/.bin/grunt