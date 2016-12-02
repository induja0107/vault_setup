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
  require addrepo
  require nodesetup::bind
  require consul_ka

  $cdadmin_path = "/opt/cdadmin/bin"

  $vault_binary_file = "vault_0.6.2_linux_amd64.zip"

  file {'unzip_install_script':
    ensure  => 'file',
    path    => "${cdadmin_path}/install_unzip.sh",
    owner   => 'nobody',
    group   => 'root',
    mode    => '0755',
    notify  => Exec['run_unzip'],
    content => '#!/bin/bash
export http_proxy=http://proxyserver.mutualofomaha.com:8080
export proxy=http://proxyserver.mutualofomaha.com:8080
echo "proxy=http://proxyserver.mutualofomaha.com:8080" >> /etc/yum.conf
sudo yum -y install unzip
export VAULT_ADDR=http://127.0.0.1:8200',
  } ->
  exec {'run_unzip':
    command     => "${cdadmin_path}/install_unzip.sh",
    refreshonly => true,
    path        => '/usr/bin/:/bin/:/usr/local/bin/',
  } ->

  file {"${cdadmin_path}/${vault_binary_file}":
    ensure => 'present',
    owner  => 'nobody',
    group  => 'root',
    source => "puppet:///modules/vault_config/$vault_binary_file",
    mode   => '0755',
  } ->

  exec { 'install_vault':
    command   => "sudo unzip $cdadmin_path/${vault_binary_file} -d /usr/bin && touch ${cdadmin_path}/one_time_install",
    subscribe => File["${cdadmin_path}/${vault_binary_file}"],
    path      => '/usr/bin/:/bin/:/usr/local/bin/',
    creates   => "${cdadmin_path}/one_time_install",
  } ->
  file {"${cdadmin_path}/vault-config.hcl":
    ensure  => 'present',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template("vault_config/vault_server_config.erb"),
  }
}
