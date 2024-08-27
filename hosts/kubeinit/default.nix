{ config, lib, pkgs, inputs, ... }:
{
  imports =[];
  config = {
    systemd.services.nixos-rebuild-flake = {
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake $Flake";
        EnvironmentFile = "/envfile.file"; # Path to the file containing FlakeVariable in the form: `Flake=github:yomaq/nix-container#kubeinit`
      };
    };
    systemd.timers.nixos-rebuild-flake = {
      timerConfig = {
        OnCalendar = "*:0/10"; # Run every 10 seconds
      };
    };
  };
}
