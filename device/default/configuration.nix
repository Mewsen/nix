{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/audio.nix
    ../../modules/virt.nix
    ../../modules/network.nix
    ../../modules/desktop.nix
    ../../modules/gaming.nix
    ../../modules/env.nix
    ../../modules/bluetooth.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # automount usb
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.michael = {
    isNormalUser = true;
    description = "michael";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs;
    [
    ]
    ++ (import ./../../modules/packages.nix pkgs);

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
  };

  system.stateVersion = "24.05";
}
