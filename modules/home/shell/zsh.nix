{lib, config, pkgs, ...}:
with lib;
let
  cfg = config.modules.shell.zsh;
in {
  options.modules.shell.zsh = {
    enable = mkEnableOption "zsh shell";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;

      history = {
        append = true;
      };

      initExtra = "setopt INC_APPEND_HISTORY";
      
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      antidote = {
        enable = true;
        plugins = [
          "MichaelAquilina/zsh-you-should-use"
          ""
        ];
      };
      
      oh-my-zsh = {
        enable = true;
      };
    };
  };
}