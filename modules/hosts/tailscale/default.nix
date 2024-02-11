{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.devcontainer.tailscale;
in
{
  options.devcontainer.tailscale = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        enable custom tailscale module
      '';
    };
  };

  config = mkIf cfg.enable {
    services.tailscale.enable = true;
  };
}