# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  # Drives
  ## Main Drive

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0d534eb1-18ee-4ee2-ab2b-252108f76f34";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/14ec737b-1d21-4799-b55b-f68cec4ac975";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/05A5-5965";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 24 * 1024;
    }
  ];

  ## Storage Drives

  fileSystems."/mnt/parity1" = {
    device = "/dev/disk/by-uuid/1b88b246-4a19-4565-b191-3928b95c8b94";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."store-st12-1".device = "/dev/disk/by-uuid/d054a86e-3c10-45f9-92f8-ee630d950093";

  fileSystems."/mnt/disk1" = {
    device = "/dev/disk/by-uuid/f3d919e7-31d7-4084-9266-b86e6f60815b";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."store-st12-2".device = "/dev/disk/by-uuid/2763697c-eeda-4011-8e30-3883767d1f45";

  fileSystems."/mnt/disk2" = {
    device = "/dev/disk/by-uuid/f97b4d0c-43fe-4073-baac-21965dfad751";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."store-sam7-1".device = "/dev/disk/by-uuid/4b57a289-01b5-4a1b-98c8-035e7849e263";

  fileSystems."/mnt/disk3" = {
    device = "/dev/disk/by-uuid/781853ff-d213-4741-b04c-f45ec7842369";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."store-sam5-1".device = "/dev/disk/by-uuid/802ce9f2-8975-4155-9f6d-ebfa49bd0829";

  ## MergerFS Pooling
  environment.systemPackages = with pkgs; [
    mergerfs
    mergerfs-tools
  ];

  fileSystems."/mnt/storage" = {
    device = "/mnt/disk*";
    fsType = "mergerfs";
    options = ["cache.files=off" "dropcacheonclose=false" "category.create=mfs" "moveonenospc=true" "minfreespace=1M"];
  };

  ## SnapRAID
  services.snapraid = {
    enable = true;
    parityFiles = [
      "/mnt/parity1/snapraid.parity"
    ];
    contentFiles = [
      "/mnt/disk1/snapraid.content"
      "/mnt/disk2/snapraid.content"
      "/mnt/disk3/snapraid.content"
    ];
    dataDisks = {
      d1 = "/mnt/disk1/";
      d2 = "/mnt/disk2/";
      d3 = "/mnt/disk3/";
    };
    sync.interval = "01:00";
    scrub.interval = "weekly";
    scrub.plan = 8;
    scrub.olderThan = 10;
    exclude = [
      "*.unrecoverable"
      "/tmp/"
      "/lost+found/"
    ];
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp5s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
