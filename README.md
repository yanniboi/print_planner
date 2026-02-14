# Print Planner

CLI-first workflow for generating 3D-printable models with OpenSCAD inside DDEV.

## Quick Start

```bash
ddev restart
ddev preview box small
ddev export box small && ddev validate box small
```

## Pipeline

1. Write a model in `models/<name>.scad`.
2. Define presets in `params/<name>/<preset>.json`.
3. Render review image: `ddev preview <name> <preset>`.
4. Export STL: `ddev export <name> <preset>`.
5. Validate STL: `ddev validate <name> <preset>`.

For all presets of a model: `ddev batch <name>`.

## Commands

- `ddev preview [--hide-scale] [--camera-preset <name>] <model> <preset>`: PNG output in `build/png/`.
- `ddev export <model> <preset>`: STL output in `build/stl/`.
- `ddev validate <model> <preset>`: Runs `admesh` checks.
- `ddev batch <model>`: Runs preview + export for every preset.

Use `--help` on any command for quick usage.

## Notes

- Preview shows a fixed 100 mm ruler by default; hide with `--hide-scale`.
- Camera presets are defined in `config/camera-presets.json`.
- Export always disables the ruler.
- Container deps are installed via `.ddev/web-build/Dockerfile`.
