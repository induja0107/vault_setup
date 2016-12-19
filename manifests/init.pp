# Class: vault_setup
# ===========================
#
# Installs vault and sets up the server configuration to connect to consul secret backend.
#
# Parameters
# ----------
# $vault_binary_file - The binary file name for vault installation. Default: vault_0.6.4_linux_amd64.zip
# $source_file - source file for vault installation. Default: 'https://releases.hashicorp.com/vault/0.6.4/vault_0.6.4_linux_amd64.zip' 
# $cdadmin_path - The path for placing all the executables like vault-config.hcl, unzip_install.sh, vault_0.6.4_linux_amd64.zip, one_time_install. Default: '/opt/cdadmin/bin'
#
# Variables
# ----------
# None 
#
# Authors
# -------
#
# Induja Vijayaragavan 
#
# Copyright
# ---------
#
# Copyright 2016 Induja Vijayaragavan, unless otherwise noted.
#
class vault_setup(String $vault_binary_file ='vault_0.6.4_linux_amd64.zip', String $source_file ='https://releases.hashicorp.com/vault/0.6.4/vault_0.6.4_linux_amd64.zip', String $cdadmin_path = '/opt/cdadmin/bin') {

  file { '/opt/cdadmin' :
    ensure => 'directory',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  } ->

  file { '/opt/cdadmin/bin' :
    ensure => 'directory',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  } ->


  file {'unzip_install_script':
    ensure  => 'file',
    path    => "${cdadmin_path}/install_unzip.sh",
    owner   => 'nobody',
    group   => 'root',
    mode    => '0755',
    notify  => Exec['run_unzip'],
    content => '#!/bin/bash
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
    source =>  $source_file,
    mode   => '0755',
  } ->

  exec { 'install_vault':
    command   => "sudo unzip ${cdadmin_path}/${vault_binary_file} -d /usr/bin && touch ${cdadmin_path}/one_time_install",
    subscribe => File["${cdadmin_path}/${vault_binary_file}"],
    path      => '/usr/bin/:/bin/:/usr/local/bin/',
    creates   => "${cdadmin_path}/one_time_install",
  } ->
  file {"${cdadmin_path}/vault-config.hcl":
    ensure  => 'present',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('vault_setup/vault_server_config.erb'),
  }
}
