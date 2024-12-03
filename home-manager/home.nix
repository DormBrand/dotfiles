{ inputs, config, pkgs, ... }:

{

  imports = [
    inputs.vscode-server.nixosModules.home
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "julius";
  home.homeDirectory = "/home/julius";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # dev

  programs.git = {
    enable = true;
    userName = "DormBrand";
    userEmail = "dorm.brand@gmail.com";
  };

  services.vscode-server.enable = true;

  # shell

  programs.bat.enable = true;
  programs.broot.enable = true;
  programs.eza.enable = true;
  programs.ripgrep.enable = true;

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

  programs.starship = {
    enable = true;
    enableTransience = true;
    settings = (builtins.fromTOML (builtins.readFile ../extras/starship.toml));
  };

  programs.tmux = {
    enable = true;
  };

  # monitoring

  programs.htop = {
    enable = true;
  };

  # services

  services = {
    ssh-agent.enable = true;
  };
}
