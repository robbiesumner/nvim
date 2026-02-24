{
  description = "My neovim configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    mkNeovim = import ./lib/mkNeovim.nix;
  in {
    packages = forAllSystems (
      system: {
        default = mkNeovim {
          inherit (nixpkgs.legacyPackages.${system}) pkgs lib;
          inherit self;
          supportJupyter = true;
        };
        noJupyter = mkNeovim {
          inherit (nixpkgs.legacyPackages.${system}) pkgs lib;
          inherit self;
          supportJupyter = false;
        };
      }
    );
    homeModules.nvim = {
      config,
      lib,
      pkgs,
      ...
    }: let
      cfg = config.programs.configured-neovim;
    in {
      options.programs.configured-neovim = {
        enable = lib.mkEnableOption "My configured neovim";
        supportJupyter = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
      };
      config = lib.mkIf cfg.enable {
        home.packages = [
          (mkNeovim {
            inherit pkgs lib self;
            inherit (cfg) supportJupyter;
          })
        ];
        home.sessionVariables.EDITOR = "nvim";
      };
    };
  };
}
