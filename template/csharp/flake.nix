{
  description = "C# Shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.dotnet-sdk_9
            pkgs.go-task
          ];
          shellHook = ''
            [ -z "$DOTNET_ROOT" ] && export DOTNET_ROOT="${dotnet9}"
            echo "dotnet version: $(dotnet --version)"
            echo "task version: $(task --version)"
            echo "DOTNET_ROOT: ${DOTNET_ROOT:-unset}"
          '';
        };
      });
}
