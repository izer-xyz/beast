{{ with printf "env/%s/proxz" (env "BALENA_APP_NAME") | secret }}{{ .Data.data.CF_DNS_API_TOKEN }}{{ end }}
