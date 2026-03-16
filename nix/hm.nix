{src}: {pkgs, ...}: let
  dependencies = import ./dependencies.nix {inherit pkgs;};
  plugins = import ./plugins.nix {inherit pkgs;};
in {
  programs.neovim = {
    enable = true;
    extraPackages = dependencies;
    plugins = plugins;
    extraLuaConfig = ''
      vim.opt.rtp:prepend("${src}")
      vim.opt.rtp:append("${src}/after")
      dofile("${src}/init.lua")
    '';
  };
}
