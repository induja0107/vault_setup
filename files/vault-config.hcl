backend "consul" {
  address = "127.0.0.1:8500"
  path = "vault/"
  scheme = "http"
  token = "5117e4c9-84a4-de4f-0404-fddec53af924"
}
listener "tcp" {
  address = "127.0.0.1:8200"
  tls_disable = 1
}

disable_mlock = true

