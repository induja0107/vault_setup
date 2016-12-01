# Class: vault_config
# ===========================
#
# Installs vault and sets up the server configuration to connect to consul secret backend.
#
# Parameters
# ----------
# None
#
# Variables
# ----------
# $cdadmin_path, $vault_binary_file
#
# Examples
# --------
#
# @example
#    class { 'vault_config':
#    }
#
# Authors
# -------
#
# Induja Vijayaragavan <induja.vijayaragavan.com>
#
# Copyright
# ---------
#
# Copyright 2016 Induja Vijayaragavan, unless otherwise noted.
#
class vault_config {

  require admin_dir_setup

  $cdadmin_path = "/opt/cdadmin/bin"

  $vault_binary_file = "vault_0.6.2_linux_amd64.zip"

  file {"${cdadmin_path}/${vault_binary_file}":
    ensure => 'present',
    owner  => 'puppet',
    group  => 'puppet',
    source => 'puppet:///modules/vault_config/$vault_binary_file',
    mode   => '0644',
  } ->

  exec { 'install_vault':
    command   => "unzip $cdadmin_path/${vault_binary_file} -d /usr/bin && touch ${cdadmin_path}/one_time_install",
    subscribe => File[$vault_binary_file],
    path      => '/usr/bin/:/bin/:/usr/local/bin/',
    creates   => '${cdadmin_path}/one_time_install',
  } ->
  file {"${cdadmin_path}/vault-config.hcl":
    ensure  => 'present',
    mode    => '0644',
    owner   => 'puppet',
    group   => 'puppet',
    content => template("vault_config/vault_server_config.erb"),
  }
}
