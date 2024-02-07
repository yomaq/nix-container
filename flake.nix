{
  description = "nix config";
  inputs = {
    # Nixpkgs
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # Secret Encription
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    # nix index for comma
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, agenix, ... }@inputs: 
  {
    #docker out
    containerImages = {
      blue = nixpkgs.dockerTools.buildLayeredImage {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; 
        modules = [ ./test2 ];
      };
    };
  };
}