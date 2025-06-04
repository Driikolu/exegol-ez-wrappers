#!/bin/bash

VALUES=$(docker container ls --format '{{.Names}}' | grep -E "^exegol-" | sed 's/exegol-//g' && echo "host")

VALUES=($VALUES)

CURRENT_ENV=$(cat /tmp/.current_env)
current_value="${CURRENT_ENV:-host}"

index=-1
for i in "${!VALUES[@]}"; do
if [ "${VALUES[$i]}" == "$current_value" ]; then
  index=$i
  break
fi
done


if [ "$1" == "next" ]; then
index=$(( (index + 1) % ${#VALUES[@]} ))
elif [ "$1" == "prev" ]; then
  index=$(( (index - 1 + ${#VALUES[@]}) % ${#VALUES[@]} ))
else
   echo "Usage: $0 {next|prev}"
   exit 1
fi

echo "${VALUES[$index]}" > /tmp/.current_env
if [ "${VALUES[$index]}" != "host" ]; then
  exegol exec -v "${VALUES[$index]}" 'bash -c "compgen -ac"' | grep -Pzo "(?s)Command received.*End of the command" | sed '1d' | sed '$d' | sort -u > /tmp/.current_compgen
fi

 
