#!/usr/bin/env bash

function list_exegol {
containers=$(docker container ls --format '{{.Names}}' | grep -E "^exegol-" | sed 's/exegol-//g' && echo "host")

CURRENT_ENV=$(cat /tmp/.current_env)
out=""
for container_name in $containers
do 
  if [[ "$container_name" == "$CURRENT_ENV" ]]; then
   out+="{\"full_text\":\"$container_name\",\"color\":\"#FFEE33\"}"
  else
   out+="{\"full_text\":\"$container_name\",\"color\":\"#AFAFAF\"}"
  fi
  out+=","
done
echo $out
}


i3status | (read line; echo "$line"; read line ; echo "$line" ; read line ; echo "$line" ; while true
do
  read line
  json_array="$(echo $line | sed -e 's/^,//')"
  echo ",["
  list_exegol
  echo $json_array | cut -c2-
done)
 
