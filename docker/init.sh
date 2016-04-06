#!/bin/bash

if [ ! -d /var/app/open-orchestra-master/open-orchestra/cache ]||[ ! -d /var/app/open-orchestra-stable/open-orchestra/cache ]; then
    /load.sh
fi

/run.sh
