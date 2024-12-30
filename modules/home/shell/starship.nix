{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.shell.starship;
in {
  options.modules.shell.starship = {
    enable = mkEnableOption "starship shell theming";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableTransience = true;
      settings = builtins.fromTOML (builtins.readFile ./starship.toml);
    };
  };
}
