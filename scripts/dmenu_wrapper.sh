#!/usr/bin/env bash

container=$(cat /tmp/.current_env)

if [ "$container" != "host" ]; then
command=$(cat /tmp/.current_compgen | dmenu -i -l 10 -p "execute in $container")
echo $command
exegol exec $container "bash -c "$command""
else
dmenu_run
fi
 
