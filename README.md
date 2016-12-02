#vault_config
Description:

This module installs unzip and vault in the node.

This module creates the vault server configuration file with consul secret backend.

This module sets the VAULT_ADDR=http://127.0.0.1:8200 so we can interact with vault without SSL keys.

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

10) End of story.
