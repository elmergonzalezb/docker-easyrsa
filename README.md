# docker-easyrsa

Container to abstract away easy-rsa. Mount a volume (or don't if you choose) to
 /pki and execute easy-rsa commands like so:

```bash
docker run --rm -it 
```

Mostly for keeping clutter out of your filesystem, and allowing you to keep 
the root CA database filesystem encrypted, unmounted, and wherever you want it
 (e.g. a flashdrive, an encrypted AWS EBS volume, etc).

If there is no actual database on the mounted /pki directory, the container's
entrypoint script will create one lazily at runtime before running your
requested command.

## Status

Wrapping up the init scripts now. Just gimme a second :)

## Handy Alias

```bash
alias easy-rsa="docker run --rm -it -v $EASY_RSA_DIR:/pki tonymke/docker-easyrsa"
```

## Common commands

_TODO_

## Author

[Tony Lechner](https://tony-lechner.com)

## License

whatever man.
