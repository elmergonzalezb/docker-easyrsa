# docker-easyrsa

Container to abstract and containerize easy-rsa. 

Keep clutter out of your filesystem, not have to deal with
dependency nonsense on non-debian distros, and allowing you to keep 
the root CA database filesystem encrypted, unmounted, and wherever you want it.

Mount a volume to /pki and execute easy-rsa commands 
like so:

```bash
alias easy-rsa="docker run --rm -it -v /a/safe/location:/pki tonymke/easy-rsa:1.0.4"

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

## Intermediary CAs

There is a dedicated script for creating an intermediary CA's database from
a root CA.

Mount the original DB, plus a folder to serve as the new one. 

```bash
# create an initial CA
docker run --rm -it \
  -v /a/safe/location/root:/pki \
  tonymke/easy-rsa build-ca

# create an intermediate CA within the root DB
docker run --rm -it \
  -v /a/safe/location/root:/pki \
  tonymke/easy-rsa build-inter ourIntermediateCa

# split off the intermediate CA into its own PKI
docker run --rm -it \
  -v /a/safe/location/root:/rootpki \
  -v /a/safe/location/ourIntermediateCa:/pki \
  tonymke/easy-rsa inherit-inter /rootpki/db/keys ourIntermediateCa
```

You can now treat the intermediate CA as a separate PKI DB entirely

## Status

Working. 

Added to public [docker hub](https://hub.docker.com/r/tonymke/easy-rsa/)

## VARS

easy-rsa uses a file to define its operating environment. This defines values 
that go into your certificates. You need to customize this before generating 
any certificates.

If no DB is detected, the entryscript will move a vars file from the root 
of your mounted directory - if it exists - into the new database. Otherwise,
it will use a sane default one.

The default vars file is included in this repo - _vars.default_.

## Notes

This container uses the latest LTS version of ubuntu in which `easy-rsa(1)`
works, 16.04. The package in Ubuntu 18.04 appears to still be in the 2.x branch
(and broken), while upstream is well into 3.x.

The 2.x release does not work with openssl 1.1 or greater - used by Ubuntu 18.04
and beyond.

## Author

[Tony Lechner](https://tony-lechner.com)

## License

MIT. See LICENSE for full text.
