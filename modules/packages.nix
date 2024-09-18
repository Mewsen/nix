{pkgs, ...}:
with pkgs; [
  # Extras
  xdg-user-dirs

  # Development
  gcc
  cargo
  lua
  neovim
  gh
  git
  nodejs
  zsh
  zsh-autosuggestions
  gnumake
  python3
  jdt-language-server
  lua-language-server
  # Go
  unstable.go
  iferr
  impl
  golines
  #nix fmt
  alejandra
  #nix lsp
  nil

  cmake
  llvmPackages_latest.lldb
  clang-tools
  llvmPackages_latest.clang
  llvmPackages_latest.libcxx
  unstable.SDL
  unstable.SDL.dev
  unstable.SDL2.dev
  unstable.SDL2

  # Utilities
  maven
  markdownlint-cli
  marksman
  ripgrep
  ueberzugpp
  texliveFull
  hugo
  wget
  lf
  amdgpu_top
  file
  htop
  unzip
  zip
  yadm
  btop
  glxinfo
  lm_sensors
  vulkan-tools
  tldr
  usbutils
  pciutils
  v4l-utils
  libvdpau
  ddcutil
]
