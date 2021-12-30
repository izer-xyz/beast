[
    {
        "name": "default",
        "id": "{{ env "BALENA_APP_NAME" }}",
        "repository": "/data",
        "storage": "{{ with printf "env/%s/backupz" (env "BALENA_APP_NAME") | secret }}{{ .Data.data.URL }}{{ end }}",
        "encrypted": true,
        "no_backup": false,
        "no_restore": false,
        "no_save_password": false,
        "nobackup_file": "",
        "keys": {
            "s3_id": "{{ with printf "env/%s/backupz" (env "BALENA_APP_NAME") | secret }}{{ .Data.data.ACCESS_KEY }}{{ end }}",
            "s3_secret": "{{ with printf "env/%s/backupz" (env "BALENA_APP_NAME") | secret }}{{ .Data.data.SECRET_KEY }}{{ end }}",
            "password": "{{ with printf "env/%s/backupz" (env "BALENA_APP_NAME") | secret }}{{ .Data.data.PASSWORD }}{{ end }}"
        },
        "filters": "",
        "exclude_by_attribute": false
    }
]
