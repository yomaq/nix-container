{ config, lib, pkgs, inputs, ... }:
{
  imports =[
    # where the modules live
    inputs.self.nixosModules.devcontainer
    # where the users live
    inputs.self.nixosModules.devcontainerUsers
  ];
  config = {
    # hostname
    networking.hostName = "devcontainer";
    # nixos version on creation
    system.stateVersion = "23.11";
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    # modules imported above, which are located at ./modules/hosts/
    devcontainer = {
      ssh.enable = true;
      tailscale.enable = true;
      openvscode-server.enable = true;
      suites = {
        packages.enable = true;
      };
      users.root.enable = true;
    };
  };
}