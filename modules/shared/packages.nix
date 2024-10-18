{ pkgs }:

with pkgs; [
  # General packages for development and system management
  kitty
  obsidian
  aspell
  aspellDicts.en
  bash-completion
  coreutils
  killall
  neofetch
  openssh
  wget
  zip
  tealdeer
  nix-your-shell
  nixd

  # Encryption and security tools
  gnupg

  # Cloud-related tools and SDKs
  docker
  docker-compose

  # Media-related packages
  dejavu_fonts
  ffmpeg
  fira-code
  font-awesome
  hack-font
  noto-fonts
  noto-fonts-emoji
  # meslo-lgs-nf

  # node development tools
  nodePackages.npm # globally install npm
  nodePackages.prettier
  nodejs

  # other langs
  rustup
  ghciwatch

  # Text and terminal utilities
  fd
  htop
  iftop
  jq
  ripgrep
  tree
  tmux
  unrar
  unzip
]
