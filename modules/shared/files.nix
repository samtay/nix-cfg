{ pkgs, config, ... }:

{
  ".zshrc".source = config.lib.file.mkOutOfStoreSymlink ./config/zsh/zshrc;
  ".zimrc".source = config.lib.file.mkOutOfStoreSymlink ./config/zsh/zimrc;
  ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink ./config/nvim;
}
