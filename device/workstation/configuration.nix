{
  config,
  pkgs,
  inputs,
  ...
}: let
  settings = {
    username = "michael";
    email = "m@tews.dev";
    hostName = "fw";
  };
in {
  imports = [
    <nixos-hardware/framework/13-inch/7040-amd>
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  home-manager = {
    users = {
      "michael" = import ./home.nix;
    };
  };

  environment.sessionVariables = rec {
    MOZ_ENABLE_WAYLAND = 1;
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
    #    XDG_RUNTIME_DIR = "/run/user/1000";
    #    XDG_SCREENSHOTS_DIR = "/home/${settings.username}/Screenshots";
    #    XDG_PICTURES_DIR = "/home/${settings.username}/Screenshots";
    NIXOS_OZONE_WL = "1";
    NIXOS_OZONE_PLATFORM = "wayland";
    QT_SCALE_FACTOR = "2";
    QT_QPA_PLATFORM = "xcb";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_WAYLAND_FORCE_DPI = "physical";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
    BUNDLE_DITOR = "nvim";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_6_9;

  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    lidSwitchExternalPower = "ignore";
    extraConfig = ''
      HandlePowerKey=suspend-then-hibernate
      IdleAction=suspend-then-hibernate
      IdleActionSec=2m
    '';
  };

  systemd.sleep.extraConfig = "HibernateDelaySec=1h";
  services.xserver.videoDrivers = ["modesetting"];

  security.pam.services.swaylock = {
    fprintAuth = false;
  };

  hardware.sensor.iio.enable = true;
  hardware.i2c.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [mesa libva];
  };

  hardware.enableAllFirmware = true;

  boot.initrd.luks.devices."luks-9e0fd976-102e-4697-95cc-903e91a49672".device = "/dev/disk/by-uuid/9e0fd976-102e-4697-95cc-903e91a49672";
  networking.hostName = "fw"; # Define your hostname.
  networking.networkmanager.enable = true;

  # automount usb
  services.devmon.enable = true;
  services.udisks2.enable = true;

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  services.fwupd.enable = true;
  hardware.framework.amd-7040.preventWakeOnAC = true;

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

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.michael = {
    isNormalUser = true;
    description = "michael";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
    ];
  };

  programs.firefox.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
  programs.dconf.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs;
    [
    ]
    ++ (import ./packages.nix pkgs);

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
  };

  programs.sway = {
    enable = true;
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
      ];
    };
    mime.enable = true;
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;
  system.stateVersion = "24.05"; # Did you read the comment?
}
