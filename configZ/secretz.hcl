exit_after_auth = true

auto_auth {
	method "approle" {
		config = {
			role_id_file_path = "/configZ/roleid"
		}
	}
}

template {
	source		= "/configZ/secretZ/vault.hcl.tpl"
	destination	= "/secretZ/vault.hcl"
}

