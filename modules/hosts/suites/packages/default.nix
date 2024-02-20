{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.devcontainer.suites.packages;
in
{
  options.devcontainer.suites.packages = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        enable devcontainer misc packages install
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gh
      just
      git
      tree
      btop
      tmux
      neofetch
      pulumi-bin
    ];
  };
}