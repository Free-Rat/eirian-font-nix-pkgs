{
  description = "Eirian font packaged for Nix";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = f:
        nixpkgs.lib.genAttrs systems (system: f (import nixpkgs { inherit system; }));
    in
    {
      packages = forAllSystems (pkgs:
        let
          version = "1.05";
        in
        {
          default = pkgs.stdenvNoCC.mkDerivation {
            pname = "eirian-font";
            inherit version;

            src = ./fonts;

            dontConfigure = true;
            dontBuild = true;

            installPhase = ''
              runHook preInstall

              install -dm755 "$out/share/fonts/truetype"
              install -dm755 "$out/share/licenses/$pname"

              cp -t "$out/share/fonts/truetype" -- *.ttf *.otf
              cp -t "$out/share/licenses/$pname" -- License.txt

              runHook postInstall
            '';

            meta = with pkgs.lib; {
              description = "Eirian, a free monospaced font by GGBotNet";
              homepage = "https://ggbot.itch.io/eirian-font";
              license = licenses.ofl;
              platforms = platforms.all;
            };
          };
        });
      defaultPackage = forAllSystems (pkgs: self.packages.${pkgs.system}.default);

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);
    };
}
