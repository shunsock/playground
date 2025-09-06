{
  description = "DevShell For Terraform";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      project_id = builtins.getEnv "GOOGLE_CLOUD_PROJECT_ID";
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.go-task
          pkgs.google-cloud-sdk
          pkgs.shellcheck
          pkgs.terraform
          pkgs.treefmt
          pkgs.tflint
        ];

        shellHook = ''
          export PROJECT_ID=${project_id}
          bash script/entry_point/shell.sh
        '';
      };
    };
}
