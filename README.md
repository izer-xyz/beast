# Home server

balena push beast

## Services

 * configz - manage config files
 * secretz - Hashi Vault secret storage
 * logz - fluent-bit + external ElasticSearch
 * proxz - Traefik reverse proxy + SSL termination

TBD

 * unifi
 * homebridge-dyson-link
 * https://github.com/brontide/inform_protocol
 * balenaSound
 * https://github.com/benbusby/whoogle-search
 * ... 


## External Dependencies

 * BalenaCloud: fleet management + RPi containers
 * ElasticSearch: log storage (could be moved to local)
 * Oracle OCI: KMS to auto unseal Hashi Vault
 * Cloudflare: public DNS 

