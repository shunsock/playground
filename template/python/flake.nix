{
  description = "Development shell with latest uv";

  inputs = {
    # Nixpkgs unstable チャネルを利用
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Rust用overlay（最新Rust toolchainなどを容易に利用）
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # overlayを適用
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ (import rust-overlay) ];
        };

        # uvのビルド定義
        uv = pkgs.rustPlatform.buildRustPackage rec {
          pname = "uv";
          version = "0.8.3";
          src = pkgs.fetchFromGitHub {
            owner = "astral-sh";
            repo = "uv";
            rev = "7e78f54e7c17804d412640f940428e6b49329232";
            sha256 = "";
          };
          cargoSha256 = "";
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [ uv ];
          shellHook = ''
            echo "Welcome to uv development shell (uv ${uv.version})"
          '';
        };
      }
    );
}

