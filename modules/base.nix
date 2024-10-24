{pkgs, ...}:
{
  # Keyboard layout
  console =
    {
      useXkbConfig = true;
      earlySetup = true;
    };

  services.xserver = {
    xkb.layout = "intlde";
    xkb.options = "eurosign:e,ctrl:nocaps,nbsp:none";
    xkb.extraLayouts.intlde = {
      description = "English (US, intl., German Umlaut)";
      languages = [ "en" "de" ];
      symbolsFile = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/rgeber/xkb-layout-us-intl-de/f3c24c3d8a3c06d96f95ee263884269969001da2/intlde";
        sha256 = "c2ef333f382ca735bcdd67181a9e5ba348a87b219ca105487e6c9616dbca46bf";
      };
    };
  };

  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
};

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Networking
  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [...];
  # networking.firewall.allowedUDPPorts = [...];

  # Fonts 
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

  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };

  # Shell
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;
  environment.systemPackages = with pkgs; [
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting

    unstable.neovim
    git
    gh

    framework-tool

    # For setting XDG Directories
    xdg-user-dirs

    gnupg
    ripgrep
    wget
    lf
    file
    unzip
    zip
    yadm
    btop

    tldr

    lm_sensors
    usbutils
    pciutils

    # For drawing images over a Terminal
    ueberzugpp
  ];

}