{
  description = "Development shell for Chipyard";

  # Nixpkgs version to use
  inputs.nixpkgs.url = "nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs }:
    let
      # System types to support.
      # I have only ever tested this on x86_64-linux, so we limit to that.
      supportedSystems = [ "x86_64-linux" ]; # "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });

    in
      {
        # This flake does not provide any packages
        packages = {};

        # This flake does not provide any packages, so it cannot have apps
        # either.
        # apps is meant to play with the "nix run" command.
        apps = {};

        # What we really want
        devShells = forAllSystems (system:
          let pkgs = nixpkgsFor.${system};
              riscvNativeBuildInputs = with pkgs; [
                # ChipYard Dependencies
                gnumake42
                coreutils moreutils binutils
                flock
                bison
                flex
                autoconf automake
                gmp mpfr libmpc zlib
                vim git jdk17
                texinfo gengetopt
                expat libusb1 ncurses cmake
              ];

          in {
            default = pkgs.mkShell {
              # nativeBuildInputs = riscvNativeBuildInputs;
              buildInputs = with pkgs; [
                # svls      # SystemVerilog Language Server
                verilator # (System)Verilog Simulator/Compiler

                # sbt
                # scala

                # perl perlPackages.ExtUtilsMakeMaker
                # # Deps for poky
                # patch diffstat texinfo subversion chrpath git wget

                # # Deps for qemu
                # gtk3 pkg-config
                # rsync libguestfs texinfo expat ctags
                # # Install dtc
                # dtc

                # # CIRCT stuff
                # jq
                # cmake ninja

                # keep this line if you use bash
                bashInteractive
              ];

              # Ensure locales are present
              LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";

              hardeningDisable = [ "all" ];

              shellHook = ''
                # Unset $OBJCOPY for compiling glibc-based RISC-V toolchain
                unset OBJCOPY
                unset OBJDUMP
              '';
            };
          });
      };
}
