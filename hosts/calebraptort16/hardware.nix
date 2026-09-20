# PLACEHOLDER. Replace this file on the laptop with:
#   nixos-generate-config --show-hardware-config > hosts/calebraptort16/hardware.nix
# Also add disks: either the generated fileSystems above, or a disko.nix like calebdtn's.
{ lib, ... }:

{
  assertions = [
    {
      assertion = false;
      message = "hosts/calebraptort16/hardware.nix is still the placeholder, generate the real one on the laptop.";
    }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
