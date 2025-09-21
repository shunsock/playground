{
  description = "DevShell for Golang";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            go_1_24
            golangci-lint
            gotests
            go-tools
            restish
          ];

          shellHook = ''
            export GOPATH="$PWD/.gopath"
            export GOMODCACHE="$PWD/.gomodcache"
            export PATH="$GOPATH/bin:$PATH"
            mkdir -p "$GOPATH" "$GOMODCACHE"
            echo "Go dev shell ready: $(go version)"
          '';
        };
      });
}

