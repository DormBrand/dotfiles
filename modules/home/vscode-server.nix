{inputs, lib, config, pkgs, ...}:
with lib;
let
  cfg = config.modules.vscode-server;
in {
  imports = [
      inputs.vscode-server.nixosModules.home
  ];

  options.modules.vscode-server = {
    enable = mkEnableOption "vscode server support";
  };
  
  config = mkIf cfg.enable {
    services.vscode-server.enable = true;
  };
}