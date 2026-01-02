{
  inputs = {
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs";
  };

  description = "Basic project templates";

  outputs =
    { devshell, nixpkgs, ... }:
    let
      system = "x86_64-linux";
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-tree;
      devShells.${system}.default =
        let
          pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = true;
            overlays = [ devshell.overlays.default ];
          };
        in
        pkgs.devshell.mkShell {
          name = "nix-config";
          motd = "{32}nix-config activated{reset}\n$(type -p menu &>/dev/null && menu)\n";

          packages = with pkgs; [
            pre-commit
          ];
        };

      templates = {
        python-basic = {
          path = ./python-basic;
          description = "Basic Python project scaffolding";
        };
      };
    };
}
