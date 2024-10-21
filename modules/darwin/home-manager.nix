{ config, pkgs, lib, home-manager, ... }:

let
  user = "samtay";
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  imports = [
   ./dock
  ];

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = false;
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }:{
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        file = lib.mkMerge [
          (import ../shared/files.nix { inherit config pkgs; })
          (import ./files.nix { inherit user config pkgs; })
        ];
        stateVersion = "24.05";
      };
      programs = import ../shared/home-manager.nix { inherit config pkgs lib; };

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      # manual.manpages.enable = false;
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local.dock.enable = false; # this doesn't seem to work anyway
  local.dock.entries = [
    { path = "/Applications/Firefox.app/"; }
    { path = "/Applications/Slack.app/"; }
    { path = "${pkgs.kitty}/Applications/Kitty.app/"; }
    { path = "/System/Applications/Facetime.app/"; }
    { path = "/System/Applications/Photo Booth.app/"; }
    { path = "/System/Applications/TV.app/"; }
    { path = "/System/Applications/Home.app/"; }
    { path = "/Applications/1Password.app/"; }
    {
      path = "${config.users.users.${user}.home}/.local/share/";
      section = "others";
      options = "--sort name --view grid --display folder";
    }
    {
      path = "${config.users.users.${user}.home}/.local/share/downloads";
      section = "others";
      options = "--sort name --view grid --display stack";
    }
  ];

}
