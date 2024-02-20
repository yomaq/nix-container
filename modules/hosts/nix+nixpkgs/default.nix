{ options, config, lib, pkgs, inputs, ... }:

with lib;
let
  cfg = config.devcontainer.nixSettings;
in
{
  options.devcontainer.nixSettings = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        enable custom nix settings
      '';
    };
  };

  config = mkIf cfg.enable {
    nix = {
      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
        # Deduplicate and optimize nix store
        auto-optimise-store = true;
      };
    };
    nixpkgs = {
      overlays = [ 
        inputs.self.overlays.pkgs-unstable
        ];
      # Configure your nixpkgs instance
      config = {
        # Disable if you don't want unfree packages
        allowUnfree = true;
      };
    };
  };
}