{ pkgs }:

let
  pypkgs-build-requirements = {
    bump2version = [ "setuptools" ];
    grimp = [ "setuptools" ];
    import-linter = [ "setuptools" ];
    xextract = [ "setuptools" ];
  };

  p2n-overrides = pkgs.poetry2nix.defaultPoetryOverrides.extend (self: super:
    builtins.mapAttrs (package: build-requirements:
      (builtins.getAttr package super).overridePythonAttrs (old: {
        buildInputs = (old.buildInputs or [ ]) ++ (builtins.map (pkg: if builtins.isString pkg then builtins.getAttr pkg super else pkg) build-requirements);
      })
    ) pypkgs-build-requirements
  );

  app = pkgs.poetry2nix.mkPoetryApplication {
    projectDir = pkgs.fetchFromGitHub {
      owner = "imankulov";
      repo = "linguee-api";
      rev = "v2.6.0";
      sha256 = "sha256-jLmDPhCD/bZU3DzvFn473dVBLVBC81N/vdnAc8QoSnI=";
    };
    overrides = p2n-overrides;
  };
in
  pkgs.writeShellApplication {
    name = "linguee-api";
    text = ''
      ${app.dependencyEnv}/bin/uvicorn linguee_api.api:app "$@"
    '';
  }
