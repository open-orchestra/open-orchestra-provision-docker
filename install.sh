#!/bin/bash

# ==========================================
# Fonctions
usage() {
  echo "--------------------------------------------------------"
  echo "Usage: ./install.sh [stable|master]"
  echo "--------------------------------------------------------"
  exit 4
}

function contains() {
    local n=$#
    local value=${!n}
    for ((i=1;i < $#;i++)) {
        if [ "${!i}" == "${value}" ]; then
            echo 1
            return 1
        fi
    }
    echo 0
    return 0
}


# ==========================================
# Main
options=("stable" "master")

#
if [[ $(contains "${options[@]}" "$1") -eq 0 ]]; then
  usage
fi

VERSION="$1"

php -r "readfile('https://getcomposer.org/installer');" | php

if [ $VERSION == "master" ] ; then
    mkdir -p open-orchestra-master
    cd open-orchestra-master
    php ../composer.phar create-project open-orchestra/open-orchestra ./open-orchestra -s dev --ignore-platform-reqs --no-scripts --keep-vcs dev-master
    php ../composer.phar create-project open-orchestra/open-orchestra-front-demo ./open-orchestra-front-demo -s dev --ignore-platform-reqs --no-scripts --keep-vcs dev-master
    php ../composer.phar create-project open-orchestra/open-orchestra-media-demo ./open-orchestra-media-demo -s dev --ignore-platform-reqs --no-scripts --keep-vcs dev-master
else
    mkdir -p open-orchestra-stable
    cd open-orchestra-stable
    php ../composer.phar create-project open-orchestra/open-orchestra ./open-orchestra -s stable --ignore-platform-reqs --no-scripts --keep-vcs
    php ../composer.phar create-project open-orchestra/open-orchestra-front-demo ./open-orchestra-front-demo -s stable --ignore-platform-reqs --no-scripts --keep-vcs
    php ../composer.phar create-project open-orchestra/open-orchestra-media-demo ./open-orchestra-media-demo -s stable --ignore-platform-reqs --no-scripts --keep-vcs
fi

cd ..
docker-compose -f docker-compose.yml -f docker-compose-$1.yml up -d
