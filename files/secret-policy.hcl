path "generic/*" {
  policy = "read"
}

path "secret/*" {
  policy = "read"
}

path "auth/token/lookup-self" {
  policy = "read"
}
