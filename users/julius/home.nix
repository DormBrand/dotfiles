{
  inputs,
  config,
  pkgs,
  ...
}: {
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
  modules.dev.vscode-server.enable = true;
  modules.dev.direnv.enable = true;

  programs.git = {
    enable = true;
    userName = "DormBrand";
    userEmail = "dorm.brand@gmail.com";
  };

  # shell
  modules.shell.zsh.enable = true;
  modules.shell.starship.enable = true;
  modules.shell.tmux.enable = true;
  modules.shell.utils.enable = true;

  # monitoring

  programs.htop = {
    enable = true;
  };

  # services

  services = {
    ssh-agent.enable = true;
  };
}
