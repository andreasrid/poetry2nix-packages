# Poetry2Nix Packages

This repository contains a collection of packages for the [Nix package manager](https://nixos.org/nix/).
These package uses the python poetry package manager, but does not provide poetry2nix.

poetry2nix turns Poetry projects into Nix derivations without the need to actually write Nix expressions. It does so by parsing pyproject.toml and poetry.lock and converting them to Nix derivations on the fly.

## How to use

    NOTE: To follow the following usage, you need to have Nix installed with flakes & new-comands enabled first.

Run packages directly from this repository:

nix run github:andreasrid/poetry2nix-packages#some-package
