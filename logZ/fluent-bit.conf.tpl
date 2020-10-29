[SERVICE]
    log_level error
    parsers_file parsers.conf

[INPUT]
    name stdin
    parser balena
    tag balena

[OUTPUT]
    name  es
    match *
    host  {{ with printf "env/%s/logz" (env "BALENA_APP_NAME") | secret }}{{ .Data.data.ELASTIC_HOST }}{{ end }}
    port  443
    index {{ with printf "env/%s/logz" (env "BALENA_APP_NAME") | secret }}{{ .Data.data.ELASTIC_INDEX }}{{ end }}
    tls   on
    tls.verify off

