with import <nix/config.nix>;

rec {
  inherit shell;

  path = coreutils;

  system = builtins.currentSystem;

  shared = builtins.getEnv "_NIX_TEST_SHARED";

  mkDerivation = args:
    derivation ({
      inherit system;
      builder = shell;
      args = ["-e" args.builder or (builtins.toFile "builder.sh" "eval \"$buildCommand\"")];
      PATH = path;
    } // removeAttrs args ["builder" "meta"])
    // { meta = args.meta or {}; };
}
