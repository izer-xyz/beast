ui = true

listener "tcp" {
	address = "0.0.0.0:8200"
	tls_disable = true
}

storage "file" {
	path = "/vault/file"
}

seal "transit" {
  address            = "{{ env "VAULT_ADDR" }}"
  token              = "{{ with secret "/auth/token/create" "no_default_policy=false" }}{{.Auth.ClientToken }}{{ end }}"

  disable_renewal    = "false"

  // Key configuration
  key_name           = "{{ env "BALENA_APP_NAME" }}"
  mount_path         = "transit/"

}

disable_clustering = true
