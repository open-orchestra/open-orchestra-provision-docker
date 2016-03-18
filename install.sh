#!/bin/bash

php -r "readfile('https://getcomposer.org/installer');" | php
php composer.phar create-project open-orchestra/open-orchestra ./open-orchestra -s dev --ignore-platform-reqs --no-scripts --keep-vcs dev-master
php composer.phar create-project open-orchestra/open-orchestra-front-demo ./open-orchestra-front-demo -s dev --ignore-platform-reqs --no-scripts --keep-vcs dev-master
php composer.phar create-project open-orchestra/open-orchestra-media-demo ./open-orchestra-media-demo -s dev --ignore-platform-reqs --no-scripts --keep-vcs dev-master
git clone git@github.com:open-orchestra/open-orchestra-provision.git

docker-compose up -d