let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  yarn = pkgs.yarn;
  yarnPackages = pkgs.yarn2nix-moretea.mkYarnWorkspace {
    inherit yarn;
    src = ./.;
  };
in
  pkgs.mkShell {
    packages = [
      pkgs.bashInteractive
      pkgs.nodejs
      yarn
    ] ++ (builtins.attrValues yarnPackages);
  }
