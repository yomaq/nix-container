{ config, lib, pkgs, inputs, modulesPath, ... }:
{
  imports =[
    inputs.nix-index-database.nixosModules.nix-index
  ];
  config = {
    networking.hostName = "devcontainer";
    system.stateVersion = "23.11";
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";


    services.sshd.enable = true;

    networking.firewall.allowedTCPPorts = [80];

    users.users.root.password = "nixos";
    services.openssh.settings.PermitRootLogin = lib.mkDefault "yes";
    services.getty.autologinUser = lib.mkDefault "root";


    programs.nix-index-database.comma.enable = true;

    environment.systemPackages = [
      pkgs.gh
      pkgs.bc
      pkgs.mc
      pkgs.vim
      pkgs.git
      pkgs.mosh
      pkgs.file
      pkgs.wget
      pkgs.tree
      pkgs.pigz
      pkgs.fish
      pkgs.curl
      pkgs.tmux
      pkgs.btop
      pkgs.tmate
      pkgs.socat
      pkgs.gnupg
      pkgs.pipenv
      pkgs.netcat
      pkgs.psmisc
      pkgs.procps
      pkgs.ripgrep
      pkgs.tcpdump
      pkgs.python3
      pkgs.pciutils
      pkgs.neofetch
    ];
  };
}