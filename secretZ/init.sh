#!/bib/sh

echo Usage: init.sh role roleid 
ROLEID=$2
ROLE=$1

echo create role: $ROLE
vault policy write $ROLE - <<EOF

path "auth/token/create" {
   capabilities = [ "update" ]
}

path "transit/encrypt/$ROLE" {
   capabilities = [ "update" ]
}

path "transit/decrypt/$ROLE" {
   capabilities = [ "update" ]
}
EOF

#CIDR=$(ip -o -f inet addr show | awk '/scope global/ {print $4}')
CIDR=0.0.0.0/0

vault write auth/approle/role/$ROLE bound_cidr_list=$CIDR bind_secret_id=false policies=$ROLE
vault write auth/approle/role/$ROLE/role-id role_id=$ROLEID

echo find and create secrets
vault secrets enable transit
vault write -f transit/keys/$ROLE


