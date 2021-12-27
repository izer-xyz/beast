#!/usr/bin/env bash

# copy every config file ( /configZ/*Z/* ) excpet *.tpl to /
tar cf - -C /configZ --exclude=\*.tpl *Z | tar xvf - -C /

echo $BALENA_DEVICE_UUID > /configZ/roleid

vault agent -config /configZ/agent.hcl 

sh
