{lib, config, pkgs, ...}:
with lib;
let
  cfg = config.modules.shell.utils;
in {
  options.modules.shell.utils = {
    enable = mkEnableOption "shell utility programs";
  };

  config = mkIf cfg.enable {
    programs.bat.enable = true;
    programs.broot.enable = true;
    programs.eza.enable = true;
    programs.ripgrep.enable = true;
    # TODO: find more shell utility programs
  };
}