{ pkgs, ... }:
let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in {

  services.libinput.mouse.accelProfile = "flat";

  services.logind = {
    lidSwitchExternalPower = "ignore";
    lidSwitchDocked = "ignore";
    powerKey = "suspend";
  };

  # Whether to enable i2c devices support.
  hardware.i2c.enable = true;

  #Provides an interface to sensors like Accelerometers and Light sensors.
  hardware.sensor.iio.enable = true;

  services.xserver.videoDrivers = [ "modesettings" ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ mesa libva amdvlk ];
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
  };

  security.polkit.enable = true;
  security.pam.services.login.fprintAuth = true;

  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    unstable.fprintd
    vulkan-tools
    glxinfo
    amdgpu_top
    v4l-utils
    libvdpau
    ddcutil
    power-profiles-daemon
    alacritty
    networkmanagerapplet
    wev
    brightnessctl
    wl-clipboard
    libreoffice
    signal-desktop
    spotify
    libva-utils
    vesktop
    obsidian
    vscode-fhs
    halloy
    ventoy-full
    unstable.zed-editor
    obs-studio
    jetbrains.idea-community
    unstable.yt-dlp
    mpv
    lazygit
    lazydocker
    yubikey-manager-qt
    yubikey-personalization
    yubioath-flutter
    altserver-linux
    unstable.libimobiledevice
    tor-browser
    filezilla
    chromium
    unstable.davinci-resolve
    gnucash
    p7zip
  ];

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";
  services.displayManager.sddm.wayland.enable = true;

  #  services.xserver.enable = true;
  #  services.xserver.desktopManager.gnome.enable = true;
  #  services.xserver.displayManager.gdm.enable = true;
  #
  #  environment.gnome.excludePackages = (with pkgs; [
  #    epiphany
  #  ]) ;

  #
  #  programs.dconf.profiles.user = {
  #    databases = [{
  #      lockAll = true;
  #      settings = {
  #        "org/gnome/mutter" = {
  #          edge-tiling = true;
  #          experimental-features = ["scale-monitor-framebuffer"];
  #          workspaces-only-on-primary = true;
  #        };
  #        "org/gnome/shell/keybindings" = {
  #          focus-active-notification = [""];
  #          switch-to-application-1 = [""];
  #          switch-to-application-2 = [""];
  #          switch-to-application-3 = [""];
  #          switch-to-application-4 = [""];
  #          switch-to-application-5 = [""];
  #          switch-to-application-6 = [""];
  #          switch-to-application-7 = [""];
  #          switch-to-application-8 = [""];
  #          switch-to-application-9 = [""];
  #          switch-to-application-10 = [""];
  #          toggle-application-view = [""];
  #          toggle-message-tray = [""];
  #          toggle-overview = [""];
  #          toggle-quick-settings = [""];
  #        };
  #        "org/gnome/settings-daemon/plugins/media-keys" = {
  #          help = [""];
  #          logout = [""];
  #          screensaver = [""];
  #        };
  #        "org/gnome/desktop/wm/keybindings" = {
  #          activate-window-menu= [""];
  #          begin-move= [""];
  #          begin-resize= [""];
  #          close=["<Shift><Super>q"];
  #          cycle-group= [""];
  #          cycle-group-backward= [""];
  #          cycle-panels= [""];
  #          cycle-panels-backward= [""];
  #          cycle-windows= [""];
  #          cycle-windows-backward= [""];
  #          maximize= [""];
  #          minimize= [""];
  #          move-to-monitor-down=["<Shift><Super>j"];
  #          move-to-monitor-left=["<Shift><Super>h"];
  #          move-to-monitor-right=["<Shift><Super>l"];
  #          move-to-monitor-up=["<Shift><Super>k"];
  #          move-to-workspace-1=["<Shift><Super>1"];
  #          move-to-workspace-2=["<Shift><Super>2"];
  #          move-to-workspace-3=["<Shift><Super>3"];
  #          move-to-workspace-4=["<Shift><Super>4"];
  #          move-to-workspace-5=["<Shift><Super>5"];
  #          move-to-workspace-6=["<Shift><Super>6"];
  #          move-to-workspace-7=["<Shift><Super>7"];
  #          move-to-workspace-8=["<Shift><Super>8"];
  #          move-to-workspace-9=["<Shift><Super>9"];
  #          move-to-workspace-10=["<Shift><Super>0"];
  #          move-to-workspace-last= [""];
  #          move-to-workspace-left= [""];
  #          move-to-workspace-right= [""];
  #          panel-run-dialog= [""];
  #          switch-applications= [""];
  #          switch-applications-backward= [""];
  #          switch-group= [""];
  #          switch-group-backward= [""];
  #          switch-panels= [""];
  #          switch-panels-backward= [""];
  #          switch-to-workspace-1=["<Super>1"];
  #          switch-to-workspace-2=["<Super>2"];
  #          switch-to-workspace-3=["<Super>3"];
  #          switch-to-workspace-4=["<Super>4"];
  #          switch-to-workspace-5=["<Super>5"];
  #          switch-to-workspace-6=["<Super>6"];
  #          switch-to-workspace-7=["<Super>7"];
  #          switch-to-workspace-8=["<Super>8"];
  #          switch-to-workspace-9=["<Super>9"];
  #          switch-to-workspace-10=["<Super>0"];
  #          switch-to-workspace-last= [""];
  #          switch-to-workspace-left= [""];
  #          switch-to-workspace-right= [""];
  #          toggle-fullscreen=[""];
  #          toggle-maximized= ["<Super>f"];
  #          unmaximize= [""];
  #        };
  #        "org/gnome/desktop/wm/preferences" = {
  #          auto-raise = false;
  #          focus-mode = "sloppy";
  #          num-workspaces = lib.gvariant.mkInt32 10;
  #          resize-with-right-button = true;
  #        };
  #        "org/gnome/settings-daemon/plugins/color" = {
  #          night-light-enabled = true;
  #        };
  #        "org/gnome/mutter/wayland/keybindings" = {
  #          restore-shortcuts = [""];
  #        };
  #        "org/gnome/mutter/keybindings" = {
  #          toggle-tiled-left = [""];
  #          toggle-tiled-right = [""];
  #        };
  #      };
  #    }];
  #  };
  #

  programs.firefox = {
    enable = true;
    wrapperConfig = { pipewireSupport = true; };
    languagePacks = [ "de" "en-US" ];
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
      DisplayMenuBar =
        "default-off"; # alternatives: "always", "never" or "default-on"
      SearchBar = "unified"; # alternative: "separate"
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        # User-Agent Swticher and Manager
        "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/user-agent-string-switcher/latest.xpi";
          installation_mode = "force_installed";
        };
        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        "{sponsorBlocker@ajay.app}" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
        };
      };
      Preferences = {
        "browser.contentblocking.category" = {
          Value = "strict";
          Status = "locked";
        };
        "extensions.pocket.enabled" = lock-false;
        "extensions.screenshots.disabled" = lock-true;
        "browser.topsites.contile.enabled" = lock-false;
        "browser.formfill.enable" = lock-false;
        "browser.search.suggest.enabled" = lock-false;
        "browser.search.suggest.enabled.private" = lock-false;
        "browser.urlbar.suggest.searches" = lock-false;
        "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" =
          lock-false;
        "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" =
          lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" =
          lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" =
          lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" =
          lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
      };
    };
  };
}
