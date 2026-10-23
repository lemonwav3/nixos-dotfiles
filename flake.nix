{ 
  description = "Hyprland on NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    qylock = {
      url = "github:Darkkal44/qylock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, stylix, qylock, nvf, ... }: {
    nixosConfigurations.nixos-machine = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
	home-manager.nixosModules.home-manager

	stylix.nixosModules.stylix

	qylock.nixosModules.default
	
	{
	  home-manager = {
	    useGlobalPkgs = true;
	    useUserPackages = true;
	    users.tali = import ./home.nix;
            users.game = import ./home-game.nix;
	    sharedModules = [ nvf.homeManagerModules.default ];
	    backupFileExtension = "backup";
	  };
	}
      ];
    };
  };
}
