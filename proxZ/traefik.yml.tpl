api:
  dashboard: true

serversTransport:
  insecureSkipVerify: true

entryPoints:
  http:
    address: ":80"
    http:
      redirections:
        entryPoint:
          to: https
          scheme: https
  https:
    address: ":443"
    http:
      tls:
        certresolver: cloudflare
        domains:
          - main:   "{{ with printf "env/%s/proxz" (env "BALENA_APP_NAME") | secret }}{{ .Data.data.DOMAIN }}{{ end }}"
            sans: "*.{{ with printf "env/%s/proxz" (env "BALENA_APP_NAME") | secret }}{{ .Data.data.DOMAIN }}{{ end }}"

providers:
  docker:
    endpoint: "unix:///var/run/balena.sock"
    exposedByDefault: false
    watch: true
    defaultRule: "Host(`{{ `{{ index .Labels \"io.balena.service-name\" }}` }}.{{ with printf "env/%s/proxz" (env "BALENA_APP_NAME") | secret }}{{ .Data.data.DOMAIN }}{{ end }}`)"

certificatesResolvers:
  cloudflare:
    acme:
      email: {{ with printf "env/%s/proxz" (env "BALENA_APP_NAME") | secret }}{{ .Data.data.DOMAIN_EMAIL }}{{ end }}
      storage: /etc/certz/acme.json
      dnsChallenge:
        provider: cloudflare
        resolvers:
          - "1.1.1.1:53"
          - "1.0.0.1:53"

