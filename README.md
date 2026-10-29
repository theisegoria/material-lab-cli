# material-lab

Turn a photograph into an editable set of game-ready PBR texture maps, from the command line, entirely on your Mac.

`material-lab` is the free command-line companion to **Material Lab** for Mac and **Material Capture** for iPhone. It runs the same derivation engine as the apps, for batches, build pipelines and scripting.

- **One photo in, a full PBR material out.** Albedo, 16-bit height, normal, roughness and ambient occlusion, plus cavity, convexity, slope and edge masks, an optional bent normal and a packed ORM map. A 1K material takes about a tenth of a second on Apple silicon.
- **Learned geometry.** `--learned` runs Microsoft's MoGe-2 normal estimator on the Neural Engine and fuses it with the photo's detail, so mortar reads as recessed between bricks and grout between tiles. The model ships with the download.
- **Seamless tiling.** `--repair-albedo auto` rebuilds the photo so it repeats on both axes, cutting along the least visible seam instead of blurring the edges.
- **39 material presets.** Start from a tuned recipe: brick, cobblestones, concrete, plaster, tile, wood planks, bark, soil, gravel, grass, denim, leather, brushed and rusted steel, copper, plastic and more (`--list-presets`).
- **Bring your own maps.** Start from a hand-painted albedo (`--authored`) and drop in your own height, normal, roughness, AO or metalness maps; Material Lab fills in the rest and keeps everything consistent.
- **Clean materials.** Remove uneven lighting (`--equalize`), physically based ambient occlusion, roughness that follows the surface's texture rather than its paint colour, relief that still reads from a few metres away (seams, fasteners, chips and dents), and metalness only when you assign it.
- **Export anywhere.** glTF, USDZ, MaterialX, Unreal, Unity (URP, Built-in and HDRP), Godot, Blender, Substance 3D, Roblox and Minecraft (LabPBR), with OpenGL or DirectX normals.
- **Built for pipelines.** Catalog batches with `--jobs`, JSON reports, watch folders, recipe files, and recipes saved in the Material Lab Mac app.
- **Inspect anything.** `--info`, `--contact-sheet` and `--diff` for any bundle.
- **Private.** No account and no network: everything happens on your Mac.

Every derived map is an estimate made from one photograph; each bundle records exactly how it was made.

## Requirements

An Apple Silicon Mac running macOS 15 Sequoia or later.

## Install

### Homebrew

```sh
brew tap theisegoria/material-lab-cli https://github.com/theisegoria/material-lab-cli
brew trust theisegoria/material-lab-cli    # Homebrew 7 asks you to trust third-party taps once
brew install material-lab
```

### Direct download

Download `material-lab-<version>-macos-arm64.tar.gz` from [Releases](https://github.com/theisegoria/material-lab-cli/releases), check it against its `.sha256`, then:

```sh
tar -xzf material-lab-1.2.0-macos-arm64.tar.gz
sudo cp -R material-lab-1.2.0-macos-arm64/{bin,share} /usr/local/
```

Keep `bin/material-lab` and `share/material-lab/` together so `--learned` finds the bundled model. The binary is signed with a Developer ID but not yet notarized. If you downloaded the archive with a browser, macOS may refuse to run it the first time; clear the quarantine flag with `xattr -dr com.apple.quarantine material-lab-1.2.0-macos-arm64`.

## Quick start

```sh
# A brick wall with learned geometry, rebuilt to tile, ready for Unreal and glTF:
material-lab --input wall.jpg --output wall --label "red brick" --preset red-brick \
    --learned --repair-albedo auto --also-export unreal,glb

# Look at the result:
material-lab --info wall.pbrmaterial
material-lab --contact-sheet wall.pbrmaterial --output wall-maps.png

# A whole folder, two at a time, with a report:
material-lab --catalog catalog.json --output materials --recipe slate.json --jobs 2 --report report.json

# Derive anything dropped into a folder:
material-lab --watch ~/Inbox/textures --output ~/Materials --learned --also-export glb
```

`man material-lab` documents every option.

## Output

A `.pbrmaterial` bundle is a folder of PNG maps and a `manifest.json` recording the recipe, the source and map hashes, the normal convention and how every map was made. `material-lab --validate` checks it. Albedo is sRGB; normals and masks are linear; height is 16-bit.

| `--export` format | Contents |
| --- | --- |
| `glb` | glTF 2.0 binary: a textured 1 m plane with base colour, normal and ORM |
| `usdz` | UsdPreviewSurface material, for Quick Look, AR Quick Look and Reality Composer |
| `materialx` | a MaterialX `standard_surface` `.mtlx` with its textures, for Houdini, Maya, Blender, USD and Omniverse |
| `unreal` | `T_<Name>_BaseColor`, `_Normal` (DirectX), `_ORM`, `_Height` |
| `unity` | URP or Built-in: `<Name>_BaseMap`, `_Normal`, `_MetallicSmoothness` (smoothness in alpha), `_Occlusion`, `_Height` |
| `unity-hdrp` | `<Name>_BaseColor`, `_Normal`, `_MaskMap` (metallic, occlusion, detail, smoothness), `_Height` |
| `godot` | albedo, normal, ORM and height for ORMMaterial3D |
| `blender` | separate base colour, normal, roughness, occlusion, metallic and height maps |
| `substance` | `<Name>_BaseColor`, `_Normal`, `_Roughness`, `_Metallic`, `_AmbientOcclusion`, `_Height` for Substance 3D Painter and Designer |
| `roblox` | SurfaceAppearance `ColorMap`, `NormalMap`, `RoughnessMap`, `MetalnessMap` (at most 1024²) |
| `minecraft-labpbr` | a resource pack with LabPBR 1.3 colour, `_n` and `_s` textures, for Iris or OptiFine shaders |

## Licence

`material-lab` is free to use, including commercially; see [LICENSE](LICENSE). Learned geometry uses Microsoft MoGe-2 (MIT) with DINOv2 modules (Apache-2.0); see [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
