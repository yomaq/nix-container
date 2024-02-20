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

    # modules imported above, which are located at ./modules/hosts/
    devcontainer = {
      ssh.enable = true;
      openvscode-server.enable = true;
      suites = {
        packages.enable = true;
      };
      users.root.enable = true;
      nixSettings.enable = true;
    };
  };
}