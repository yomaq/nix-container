{
  description = "nix config";
  inputs = {
    # Nixpkgs
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # nix index for comma
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    # nixos-generators
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, ... }@inputs: 
    {
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
    };
  };
}