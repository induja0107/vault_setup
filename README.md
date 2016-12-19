#vault_config
Description:

    This module installs unzip and vault in the node.

    This module creates the vault server configuration file with consul secret backend.

    This module sets the VAULT_ADDR=http://127.0.0.1:8200 so we can interact with vault without SSL keys.



Pre-requisites:

    1) Consul should be installed and up and running.

    2) Modify files/vault-config.hcl to add your consul write ACL token so vault can interact with consul backend.

    3) Proxy is added and is all set.

    4) The templates/ needs the consul ACL token, so create a key value for consul_write_token in hiera so this module can make use of it for vault server config.
    
    5) Parameters you need to pass for this class: 
   
         $vault_binary_file - The binary file name for vault installation. Default: vault_0.6.4_linux_amd64.zip

         $source_file - source file for vault installation. Default: 'https://releases.hashicorp.com/vault/0.6.4/vault_0.6.4_linux_amd64.zip'

         $cdadmin_path - The path for placing all the executables like vault-config.hcl, unzip_install.sh, vault_0.6.4_linux_amd64.zip, one_time_install. Default: '/opt/cdadmin/bin'


Things to do after this module is installed:

    1) Login to the node that used this module for vault installation

    2) export VAULT_ADDR=http://127.0.0.1:8200 

    3) vault server -config /opt/cdadmin/bin/vault-config.hcl & 

    4) vault status

       This should show that vault is sealed.

    5) vault unseal

       Enter key1

    6) vault unseal

       Enter key2

    7) vault unseal

       Enter key3

    8) Now the new node has vault service started and is up and running.

    9) If an existing node goes away, this new node automatically gets elected as the vault server in the cluster.

Word of Caution:

    This is intended only for dev and test environments, please do not use it on production environment boxes as SSL keys are not configured yet. Use the ssl certs and https when you are production ready and have working certificates for your environments.
