{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.devcontainer.openvscode-server;
in
{
  options.devcontainer.openvscode-server = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        enable custom openvscode-server module
      '';
    };
  };

  config = mkIf cfg.enable {
    services = {
      openvscode-server = {
        package = pkgs.unstable.openvscode-server;
        enable = true;
      };
    };
  };
}