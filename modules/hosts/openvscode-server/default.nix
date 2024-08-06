{ options, config, lib, pkgs, ... }:

with lib;
let
  pname = "openvscode-server";
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

    systemd.tmpfiles.rules = [
      "d data/${pname}/userdata 0755 admin"
      "d data/${pname}/extensions 0755 admin"
      "d data/${pname}/admin 0755 admin"
    ];

    services.code-server = {
      enable = true;
      user = "admin";
      auth = "none";
      # hashedPassword
      userDataDir = "data/${pname}/userdata";
      disableTelemetry = true;
      disableUpdateCheck = true;
      disableWorkspaceTrust = true;
      extensionsDir = "data/${pname}/extensions";
      host = "127.0.0.1";
      port = 3000;
      package = pkgs.vscode-with-extensions.override {
        vscode = pkgs.code-server;
        vscodeExtensions = with pkgs.vscode-extensions; [
          bbenoist.nix
          dracula-theme.theme-dracula
          ms-python.python
        ];
      };
    };
  };
}