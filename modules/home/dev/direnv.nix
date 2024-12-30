{inputs, lib, config, pkgs, ...}:
with lib;
let
  cfg = config.modules.dev.direnv;
in {

  options.modules.dev.direnv = {
    enable = mkEnableOption "direnv for nix";
  };
  
  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}