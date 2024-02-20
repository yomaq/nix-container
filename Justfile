# just is a command runner, Justfile is very similar to Makefile, but simpler.


default:
  just --list

# Update the flake
update:
  nix flake update

vmtest:
    nixos-rebuild build-vm --flake .#vmtest

# Build, import, and run the docker container
docker-full:
    nix build .#docker && \
    sudo docker import result/tarball/nixos-system-x86_64-linux.tar.xz nixdevcontainer && \
    sudo docker run --privileged -it nixdevcontainer /init