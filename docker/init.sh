#!/bin/bash

if [ ! -d /var/app/open-orchestra/cache ]; then
    /load.sh
fi

/run.sh
