{pkgs, ...}: {
  environment.systemPackages = with pkgs;
    [
      # Development
      gcc
      cargo
      rustc
      rust-analyzer
      lua
      luarocks
      nodejs
      gnumake
      python3
      jdt-language-server
      lua-language-server
      nodePackages.typescript-language-server
      # Go
      unstable.go
      gotools
      #nix fmt
      alejandra
      #nix lsp
      nil

      hugo
      marksman

      maven
      markdownlint-cli

      texliveFull
    ];

    programs.direnv.enable = true;
}
