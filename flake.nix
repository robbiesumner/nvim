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
    nixpkgsFor = forAllSystems (system: import nixpkgs {inherit system;});
  in {
    packages = forAllSystems (
      system: let
        pkgs = nixpkgsFor.${system};
        dependencies = import ./nix/dependencies.nix {inherit pkgs;};
        plugins = import ./nix/plugins.nix {inherit pkgs;};
      in {
        default = import ./nix/neovim.nix {
          inherit pkgs dependencies plugins;
          src = self;
        };
      }
    );
    apps = forAllSystems (system: {
      default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/nvim";
      };
    });
    homeManagerModules.neovim = import ./nix/hm.nix {
      src = self;
    };
  };
}
