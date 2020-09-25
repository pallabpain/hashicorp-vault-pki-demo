# Hashicorp Vault: PKI Demo

## Overview
The scripts in this repository do the following things:
* Create a root CA
* Create an intermediate CA
* Create a CSR (Certificate Signing Request) and get it signed by root CA
* Enable intermediate CA
* Create new certificates and provide it to our nginx server
* Trust the root certificate on our system and access nginx

## Pre-requisites
* docker
* vault (client installed on your system)
