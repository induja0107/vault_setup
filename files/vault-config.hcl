backend "consul" {
  address = "127.0.0.1:8500"
  path = "vault/"
  scheme = "http"
  token = "Key In your consul write ACL token here"
  cluster_addr="http://127.0.0.1:8201"
}
listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}
disable_mlock = true

