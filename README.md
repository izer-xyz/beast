# Home server

Need docker swarm to enable secrets:
```
docker swarm init --task-history-limit 1 --default-addr-pool x.x.0.0/16
```

```
docker stack up --compose-file docker-compose.yml beast
```

## Services

 * proxz - Traefik reverse proxy + SSL termination
 * unifi - Ubiquiti Unifi Network Application (Wifi)
 * uisp - Ubiquity Network (router)
 * esp - ESPHome IoT
 * hass - Home Assitant - Automation
 * backupz/restore - Duplicacy backup
 * portainer/tailz - tailscale proxy
 * portainer - manage containers

TBD

 * logz - fluent-bit + external ElasticSearch
 * https://github.com/brontide/inform_protocol
 * ... 


## External Dependencies

 * Cloudflare: public DNS 

