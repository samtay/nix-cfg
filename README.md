# nix-cfg

Modified from [dustinlyons/nixos-config](https://github.com/dustinlyons/nixos-config/).
Ripped out its brew management.

# usage

```shell
nix run .#build-switch
```

# todo

Install bundle / brewfile thing and keep brewfile here.

- brews:
  - ca-certificates
  - ghcup
  - icu4c@75
  - krb5
  - lz4
  - mas
  - openssl@3
  - postgresql@14
  - readline

and [casks](./modules/darwin/casks.nix)
