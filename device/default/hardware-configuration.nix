# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "thunderbolt" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.kernelModules = [ "kvm-amd" "v4l2loopback" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  services.fwupd.enable = true;
  hardware.framework.amd-7040.preventWakeOnAC = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-e4d02d9b-27b2-4169-882b-011111a14a41".device =
    "/dev/disk/by-uuid/e4d02d9b-27b2-4169-882b-011111a14a41";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/241308ee-789e-4909-a07d-e32d8a59e916";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-4c98d26f-e4c9-4807-8aa0-bf90778ac40b".device =
    "/dev/disk/by-uuid/4c98d26f-e4c9-4807-8aa0-bf90778ac40b";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/87CE-6EEE";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/53a7ef39-9841-496d-bc65-69ab5f9c7fba"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eth0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
