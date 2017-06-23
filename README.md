# docker-easyrsa

Container to abstract and containerize easy-rsa. 

Keep clutter out of your filesystem, not have to deal with
dependency nonsense on non-debian distros, and allowing you to keep 
the root CA database filesystem encrypted, unmounted, and wherever you want it
 (e.g. a flashdrive, an encrypted AWS EBS volume that's mostly detached, etc).

Mount a volume (or don't if you choose) to /pki and execute easy-rsa commands 
like so:

```bash
alias easy-rsa="docker run --rm -it -v /a/safe/location:/pki tonymke/easy-rsa"

#create a new root CA
easy-rsa build-ca

#create a server cert (do not give a password)
easy-rsa build-key-server server.domain.name

#build Diffie-Hellman
easy-rsa build-dh

#export cert to local machine's web server
easy-rsa cat keys/server.domain.name.crt > /etc/nginx/ssl/some.domain.name.crt
easy-rsa cat keys/server.domain.name.key > /etc/nginx/ssl/some.domain.name.key

#export CA's public key for clients' trusted CA stores
easy-rsa cat keys/ca.crt > ~/myCa.crt
```

If there is no actual database on the mounted /pki directory, the container's
entrypoint script will create one lazily at runtime before running your
requested command.

## Status

Working. 

Added to public [docker hub](https://hub.docker.com/r/tonymke/easy-rsa/)

## VARS

easy-rsa uses a file to define its operating environment. This defines values 
that go into your certificates. You need to customize this before generating 
any certificates.

If no DB is detected, the entryscript will move a vars file from the root 
of your mounted directory - if it exists - into the new database. Otherwise,
it will simply use easy-rsa's default.

A sample vars file is included in this repo - _vars.default_ - 
(easy-rsa's default).

## Author

[Tony Lechner](https://tony-lechner.com)

## License

MIT. See LICENSE for full text.
