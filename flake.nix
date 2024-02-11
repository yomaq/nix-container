{
  description = "nix config";
  inputs = {
    # Nixpkgs
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # nixos-generators
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, ... }@inputs: 
    {
      nixosConfigurations = {
        # vm output for testing purposes
        vmtest = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; }; 
          modules = [ ./hosts/vmtest ];
        };
      };
      packages.x86_64-linux = {
        docker = nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          format = "docker";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/docker ];
        };
        kubevirt = nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          format = "kubevirt";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/docker ];
        };
        amazon = nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          format = "amazon";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/docker ];
        };
    };
### Module outputs
    nixosModules = {
      # modules/hosts options
      devcontainer = import ./modules/hosts;
      devcontainerUsers = import ./users;
    };
  };
}