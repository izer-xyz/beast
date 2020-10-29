#!/usr/bin/env bash

cd /configZ

if [ ! -f /root/.oci/config ]; then 
  echo KMS auth...
  oci setup config
  
  echo KMS config...
  cat ocikms.hcl.tpl > /root/.oci/ocikms.hcl 
  vi /root/.oci/ocikms.hcl 

  chmod -R +r /root/.oci 

  echo add this public key to the OCI key user:  
  cat /root/.oci/oci_api_key_public.pem

  echo wait little...
  sleep 10
fi

export VAULT_FORMAT=json

if [ ! $VAULT_TOKEN ]; then
  MY_VAULT_INIT=$(vault operator init -recovery-shares=1 -recovery-threshold=1)
  
  echo $MY_VAULT_INIT
  
  export VAULT_TOKEN=$( jq -r ".root_token" <<< $MY_VAULT_INIT )
  MY_VAULT_UNSEAL_KEY=$( jq -r ".unseal_keys_b64[]" <<< $MY_VAULT_INIT )
  
  vault auth enable approle
  vault secrets enable -path=env kv-v2

  echo wait little...
  sleep 5
fi

ROLEID=$BALENA_DEVICE_UUID
ROLE=$BALENA_APP_NAME

echo create role: $ROLE
vault policy write $ROLE - <<EOF
path "env/data/$ROLE/*" {
  capabilities = ["read"]
}
EOF

CIDR=$(ip -o -f inet addr show | awk '/scope global/ {print $4}')
vault write auth/approle/role/$ROLE bound_cidr_list=$CIDR bind_secret_id=false policies=$ROLE
vault write auth/approle/role/$ROLE/role-id role_id=$ROLEID

echo find and create secrets

vault kv put env/$ROLE/logz \
	ELASTIC_HOST="$ELASTIC_HOST" \
	ELASTIC_INDEX="$ELASTIC_INDEX"

vault kv put env/$ROLE/proxz \
	DOMAIN="$DOMAIN" \
	DOMAIN_EMAIL="$DOMAIN_EMAIL" \
	CF_DNS_API_TOKEN="$CF_DNS_API_TOKEN"

echo Init done time to reboot...
# reboot
