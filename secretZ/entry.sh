#!/usr/bin/env bash

# copy every config file ( /configZ/*Z/* ) excpet *.tpl to /
tar cf - -C /configZ --exclude=\*.tpl *Z | tar xvf - -C /

echo $BALENA_DEVICE_UUID > /configZ/roleid

vault agent -config /configZ/secretz.hcl 

export VAULT_ADDR=http://secretz:8200 
export VAULT_API_ADDR=http://secretz:8200 

echo start vault server
exec docker-entrypoint.sh server

