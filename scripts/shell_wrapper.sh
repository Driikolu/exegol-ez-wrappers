#!/bin/bash

if [ "$(cat /tmp/.current_env)" == "host" ]; then
  i3-sensible-terminal 
else
  i3-sensible-terminal -e exegol start $(cat /tmp/.current_env)
fi
 
