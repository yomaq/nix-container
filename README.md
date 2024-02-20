from an x86 system with nix installed with flake support: (install nix with flake support on any linux system with ```curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install```)

1
```nix build .#docker```

2
```sudo docker import result/tarball/nixos-system-x86_64-linux.tar.xz nixdevcontainer```

3
```sudo docker run --privileged -it nixdevcontainer /init ```