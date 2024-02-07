{ pkgs ? import <nixpkgs> { }
, pkgsLinux ? import <nixpkgs> { system = "x86_64-linux"; }
}:

pkgs.dockerTools.buildImage {
  name = "hello-docker";
  contents = [ 
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
  config = {
    hostname = "";
    domainname = "";
    user = "vscode";
    attachStdin = false;
    attachStdout = false;
    attachStderr = false;
    exposedPorts = {
      "6000/tcp" = {};
      "7681/tcp" = {};
    };
    tty = false;
    openStdin = false;
    stdinOnce = false;
    env = [
      "PATH=/home/vscode/.krew/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin:/nix/var/nix/profiles/default/bin"
      "LC_ALL="
      "TZ=UTC"
      "DEBIAN_FRONTEND=noninteractive"
      "NIX_INSTALLER_EXTRA_CONF=filter-syscalls = false"
      "SHELL=/usr/bin/fish"
      "REGISTRY_AUTH_FILE=/home/vscode/.docker/config.json"
      "XDG_CONFIG_HOME=/home/vscode/.config"
    ];
    cmd = [
      "/usr/bin/env"
      "connect"
    ];
    healthcheck = {
      test = [
        "CMD"
        "true"
      ];
      interval =  120000000000;
      timeout =  30000000000;
      startPeriod =  5000000000;
      retries =  3;
    };
    argsEscaped = true;
    image = "";
    volumes = null;
    workingDir = "/home/vscode";
    entrypoint = [
      "/bin/entrypoint"
    ];
    onBuild = null;
    labels = {
    };
    shell = [
      "/bin/bash"
      "-c"
      "-e"
    ];
  };
}