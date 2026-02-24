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
    mkNeovim = import ./lib/myNeovim.nix;
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
    homeManagerModules.default = {
      config,
      lib,
      pkgs,
      ...
    }: let
      cfg = config.programs.custom-neovim;
    in {
      options.programs.custom-neovim = {
        enable = lib.mkEnableOption "My custom neovim";
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
