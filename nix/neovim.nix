{
  pkgs,
  src,
  dependencies,
  plugins,
}:
pkgs.wrapNeovim pkgs.neovim-unwrapped {
  configure = {
    customLuaRC = ''
      vim.opt.rtp:prepend("${src}")
      vim.opt.rtp:append("${src}/after")
      vim.g.soundfont_path = "${pkgs.soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2"
      dofile("${src}/init.lua")
    '';
    packages.myPackage = {
      start = plugins;
    };
  };

  extraMakeWrapperArgs = pkgs.lib.escapeShellArgs [
    "--prefix"
    "PATH"
    ":"
    "${pkgs.lib.makeBinPath dependencies}"
  ];
}
