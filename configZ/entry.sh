#!/usr/bin/env bash

# copy every config file ( /configZ/*Z/* ) excpet *.tpl to /
( cd /configZ && tar cf - --exclude=\*.tpl *Z ) | ( cd / && tar xvf - --keep-newer-files ) 

# .oci is a permanenet volume but /secretZ is tmpfs...
cp /root/.oci/ocikms.hcl /secretZ/

echo $BALENA_DEVICE_UUID > /configZ/roleid
vault agent -config /configZ/agent.hcl

balena-idle
