{lib, config, pkgs, ...}:
with lib;
let
  cfg = config.modules.shell.tmux;
in {
  options.modules.shell.tmux = {
    enable = mkEnableOption "tmux";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      # TODO: configure tmux further
    };
  };
}