{
  description = "Node pkgs environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        inherit (pkgs) importNpmLock;
        # Node のバージョンはここで固定
        nodejs = pkgs.nodejs_24;
        # package.json / lockfile の場所
        npmRoot = ./node-pkgs;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            importNpmLock.hooks.linkNodeModulesHook
          ];
          npmDeps = importNpmLock.buildNodeModules {
            inherit npmRoot nodejs;
          };
        };

        # パッケージ更新作業用の環境
        devShells.node = pkgs.mkShell {
          packages = [
            nodejs
          ];
          shellHook = ''
            cd node-pkgs
            echo "Node.js version: $(node -v)
            npm install -D <package-name>@<version> --package-lock-only
            # npm uninstall -D <package-name> --package-lock-only
            npm install --package-lock-only"
          '';
        };
      }
    );
}
