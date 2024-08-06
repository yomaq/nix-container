{ options, config, lib, pkgs, ... }:

with lib;
let
  uname = "name";
  cfg = config.devcontainer.users."${uname}";
in
{
  options.devcontainer.users."${uname}" = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        enable "${uname}" user config
      '';
    };
  };

  config = mkIf cfg.enable {  
    users.mutableUsers = false;
    # Configure admin account
    users.users.admin = {
      isNormalUser = true;
      description = "admin";
      # disable password for admin account
      hashedPassword = null;
      shell = pkgs.zsh;
      extraGroups = [ "networkmanager" "wheel" ];
    };
    # Enable admin account to use ssh without password (since the admin account doesn't HAVE a password)
    security.sudo.extraRules = [
      {
        users = [ "admin" ];
        commands = [ { command = "ALL"; options = [ "NOPASSWD" ]; } ];
      }
    ];
  };
}