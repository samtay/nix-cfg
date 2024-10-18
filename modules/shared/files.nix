{ pkgs, config, ... }:

{
  ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nix-cfg/modules/shared/config/zsh/zshrc";
  ".zimrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nix-cfg/modules/shared/config/zsh/zimrc";
  ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nix-cfg/modules/shared/config/nvim";
}
