# just is a command runner, Justfile is very similar to Makefile, but simpler.


default:
  just --list

# Update the flake
update:
  nix flake update

vmtest:
    nixos-rebuild build-vm --flake .#vmtest


