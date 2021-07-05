#!/usr/bin/env bash

if [ ! -f /usr/sbin/smbd ]; then 
  apt update  -qq
  apt install -qq -y curl make golang-go git less vim tmux samba --no-install-recommends 

  CUSER=${USERNAME:=code}
  CPASS=${PASSWORD:=code}

  useradd -s /bin/bash -d /code -u 10000  $CUSER 
  
  addgroup smbgroup 
  usermod -aG smbgroup $CUSER
  printf "${CPASS}\n${CPASS}\n" | smbpasswd -a -s $CUSER
  smbpasswd -e $CUSER

fi

echo "[global]
   workgroup = WORKGROUP
   netbios name = balena-samba
   security = user
   map to guest = bad user
   server role = standalone server
   obey pam restrictions = yes
   log level = 1
   socket options = TCP_NODELAY IPTOS_LOWDELAY SO_RCVBUF=131072 SO_SNDBUF=131072

[code]
  path = /code
  valid users = @smbgroup
  guest ok = no
  writable = yes
  browsable = yes
  " > /etc/samba/smb.conf

smbd $@

