# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.graceful = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd = {
    network = {
      enable = true;
      udhcpc.enable = true;
      flushBeforeStage2 = true;
      ssh = {
        enable = true;
        port = 2222;  # Use a separate port to prevent conflict in your known
                      # hosts
        shell = "/bin/cryptsetup-askpass";
        hostKeys = [ /etc/secrets/initrd/ssh_host_ed25519_key ];
        authorizedKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC9QDOf9w9OojC2ZGYsH4r1UOacEKyOZUeMVwuGlMsGY julius@DESKTOP-5A890" ];
      };
    };
    availableKernelModules = [ "e1000e" ];
  };
  
  networking = {
    hostName = "amber";
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  programs.zsh.enable = true;

  users.defaultUserShell = pkgs.zsh;
  users.users.julius = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC9QDOf9w9OojC2ZGYsH4r1UOacEKyOZUeMVwuGlMsGY julius@DESKTOP-5A890JT"
    ];
    initialPassword = "justthebeginningofeverything";
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  hardware.sensor.hddtemp = {
    enable = true;
    drives = [
      "/dev/disk/by-id/ata-SAMSUNG_HD502HJ_S20BJA0B918696"
      "/dev/disk/by-id/ata-SAMSUNG_HD753LJ_S13UJ90S701628"
      "/dev/disk/by-id/ata-ST12000DM0007-2GR116_ZJV2V08A"
      "/dev/disk/by-id/ata-ST12000DM0007-2GR116_ZJV29496"
    ];
    dbEntries = [
      "\"SAMSUNG HD502HJ\" 194 C \"Samsung 500GB\""
      "\"SAMSUNG HD753LJ\" 190 C \"Samsung 750GB\""
      "\"ST12000DM0007-2GR116\" 190 C \"Seagate Barracuda Pro 12GB ST12000DM0007ST12000DM0007\""
    ];
  };

  environment.systemPackages = with pkgs; [
    nix-index
    hddtemp
    lm_sensors
    e2fsprogs
    smartmontools
    (import ../../packages/scripts/nix-disk-burnin/disk-burnin.nix { inherit pkgs; })
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  system.stateVersion = "24.11";

}
