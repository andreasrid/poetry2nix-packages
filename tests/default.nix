{ pkgs ? import <nixpkgs> { } }:
{
  linguee-api = import ./linguee-api.nix { inherit pkgs; };
}
