backend "consul" {
  address = "127.0.0.1:8500"
  path = "vault/"
  scheme = "http"
  token = "5117e4c9-84a4-de4f-0404-fddec53af924"
  cluster_addr="http://127.0.0.1:8201"
}
listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}
disable_mlock = true

