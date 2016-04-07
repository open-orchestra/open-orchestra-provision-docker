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

docker rm -f app_open_orchestra_$1
docker rmi openorchestraprovisiondocker_app
docker-compose -f docker-compose.yml -f docker-compose-$1.yml up -d
