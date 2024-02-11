{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.devcontainer.users.root;
in
{
  options.devcontainer.users.root = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        enable root user config
      '';
    };
  };

  config = mkIf cfg.enable {  
    users.users.root.password = "nixos";
    services.openssh.settings.PermitRootLogin = lib.mkDefault "yes";
    services.getty.autologinUser = lib.mkDefault "root";
  };
}