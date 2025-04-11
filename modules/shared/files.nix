{ pkgs, config, ... }:

{
  ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nix-cfg/modules/shared/config/zsh/zshrc";
  ".zimrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nix-cfg/modules/shared/config/zsh/zimrc";
  ".config/zed/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nix-cfg/modules/shared/config/zed/settings.json";
  ".config/zed/keymap.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nix-cfg/modules/shared/config/zed/keymap.json";
  ".config/zed/tasks.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nix-cfg/modules/shared/config/zed/tasks.json";
  ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nix-cfg/modules/shared/config/nvim";
  ".psqlrc".text = ''
    \x auto
  '';
}
