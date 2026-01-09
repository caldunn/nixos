{ lib, config, ... }:

with lib;

{
  options.nonfoss = mkOption {
    type = types.listOf types.str;
    default = [ ];

    description = "Add package names to allow it to use unfree software.";
  };

  config = {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.nonfoss;
  };

}
