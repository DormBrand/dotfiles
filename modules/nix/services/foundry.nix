{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.services.foundry;
in {
  imports = [
    inputs.foundryvtt.nixosModules.foundryvtt
  ];

  options.modules.services.foundry = {
    enable = mkEnableOption "foundryvtt";
  };

  config = mkIf cfg.enable {
    services.foundryvtt = {
      enable = true;
      minifyStaticFiles = true;
      package = inputs.foundryvtt.packages.${pkgs.system}.foundryvtt_12;
      upnp = false;
      port = 30123;
      sslCert = certs/foundry.crt;
      sslKey = certs/foundry.key;
    };

    networking.firewall = {
      allowedTCPPorts = [30123];
    };
  };
}