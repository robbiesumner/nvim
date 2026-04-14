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
      vim.g.soundfont_path = "${pkgs.soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2"
      dofile("${src}/init.lua")
    '';
  };
}
