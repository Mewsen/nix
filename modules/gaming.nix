{pkgs, ...}: {
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    lutris
    wine
    wowup-cf
    protonup
  ];
}
