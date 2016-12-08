#vault_config
Description:

    This module installs unzip and vault in the node.

    This module creates the vault server configuration file with consul secret backend.

    This module sets the VAULT_ADDR=http://127.0.0.1:8200 so we can interact with vault without SSL keys.



Pre-requisites:

    1) Consul should be installed and up and running.

    2) Modify files/vault-config.hcl to add your consul write ACL token so vault can interact with consul backend.

    3) Proxy is added and is all set.

    4) Edit the templates/ to contain the consul ACL token.



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

    This is intended only for dev and test environments, please do not use it on production environment boxes as SSL keys are not configured yet.
