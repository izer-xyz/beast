#!/usr/bin/env sh

# copy every config file ( /configZ/*Z/* ) excpet *.tpl to /
tar cf - -C /configZ --exclude=\*.tpl *Z | tar xvf - -C /

echo $BALENA_DEVICE_UUID > /configZ/roleid

vault agent -config /configZ/secretz.hcl 

export VAULT_ADDR=http://localhost:8200 
export VAULT_API_ADDR=http://localhost:8200 
vault agent -config /configZ/agent.hcl &

echo start vault server
exec docker-entrypoint.sh server

