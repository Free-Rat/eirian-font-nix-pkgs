# eirian-font-nix-pkgs

[Eirian](https://ggbot.itch.io/eirian-font) - a free monospaced font by GGBotNet.

## About

- Font: Eirian
- License: SIL Open Font License 1.1 (OFL)

This flake packages the Eirian font for use with Nix, NixOS, and Home Manager.

## Usage

Add as a flake input:

```nix
{
  inputs.eirian-font.url = "github:Free-Rat/eirian-font-nix-pkgs";
}
```

In your system or home manager configuration:

```nix
fonts.packages = [
  inputs.eirian-font.packages.${pkgs.system}.default
];
```

Then rebuild:

```bash
nixos-rebuild switch
```

## Notes

- This repository does not modify the font files
- Reserved Font Name (RFN) rules from OFL are respected
- Only redistribution/packaging is performed
