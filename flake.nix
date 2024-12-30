{
  description = "My nixos dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in {
    nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    formatter."${system}" = pkgs.alejandra;

    nixosConfigurations.amber = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/amber/configuration.nix
        ./modules/nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [
            ./modules/home
          ];
          home-manager.users.julius = import ./users/julius/home.nix;
          home-manager.extraSpecialArgs = {inherit inputs;};
        }
      ];
    };

    devShells."${system}".default = pkgs.mkShell {
      packages = [
        pkgs.alejandra
        pkgs.nixd
      ];
    };
  };
}
