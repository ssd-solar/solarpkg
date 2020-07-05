# solarpkg

solarpkg is a community-maintained addon repo for solarOS and nixOS

It contains packages maintained by the solar community that aren't quite ready yet for nixpkgs or are being tested in their early stages, aswell as packages dependent on tools not available upstream

(Note for core: System-related packages, such as the solar tools, belong in the solaros-nix repo)

# Usage

The channel can be directly imported/used as `<solarpkg>` (ex: `nix-env -iA solarpkg.jdownloader`) or be added as an overlay (`{ overlays = [ (import <solarpkg/pkgs/overlay.nix>) ]; }`)
