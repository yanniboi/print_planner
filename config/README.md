# Config

This directory stores shared configuration used by DDEV command scripts.

## Camera Presets

File: `camera-presets.json`

Each top-level key is a preset name you can pass to:

`ddev preview --camera-preset <name> <model> <preset>`

### Format

```json
{
  "preset-name": {
    "camera": "tx,ty,tz,rx,ry,rz,dist",
    "projection": "perspective"
  }
}
```

- `camera` is required.
- `projection` is optional (`perspective` or `orthogonal`).

### Camera fields

The `camera` value uses OpenSCAD's rotate-distance form:

`tx,ty,tz,rx,ry,rz,dist`

- `tx,ty,tz`: translate the camera target (what point you are looking at).
- `rx,ry,rz`: rotation angles in degrees.
- `dist`: camera distance from the target (larger = zoom out, smaller = zoom in).

Tip: keep `tx,ty,tz` at `0,0,0` unless you need to frame an off-center model.

### Projection behavior

- `perspective`: realistic depth, far objects appear smaller.
- `orthogonal`: no perspective distortion, parallel lines stay parallel.

If `projection` is omitted in a preset, the script does not pass `--projection`, so OpenSCAD uses its own default projection for that version/build.

If `--camera-preset` is not used at all, `ddev preview` falls back to `--autocenter --viewall` (OpenSCAD default camera angle, auto-fit framing).

### Example

```json
{
  "iso": {
    "camera": "0,0,0,55,0,35,220",
    "projection": "perspective"
  },
  "front": {
    "camera": "0,0,0,0,0,0,220",
    "projection": "orthogonal"
  }
}
```

To add a new view, add another top-level object and use its key as the preset name.

## Slicer Presets

File: `slicer-presets.json`

Maps printer keys to PrusaSlicer profile files used by `ddev slice`.

### Format

```json
{
  "printer-key": {
    "profile": "slicer/prusa/profiles/printer-key.ini",
    "vendor_ini": "/usr/share/PrusaSlicer/profiles/Vendor.ini",
    "printer_profile": "Vendor Printer Name",
    "print_profile": "Vendor Print Profile Name",
    "material_profile": "Vendor Material Profile Name"
  }
}
```

### Example

```json
{
  "anycubic_mega_s": {
    "profile": "slicer/prusa/profiles/anycubic_mega_s.ini",
    "vendor_ini": "/usr/share/PrusaSlicer/profiles/Anycubic.ini",
    "printer_profile": "Anycubic i3 Mega S",
    "print_profile": "0.20mm QUALITY @MEGA",
    "material_profile": "Generic PLA @MEGA"
  }
}
```

Use with:

`ddev slice --printer anycubic_mega_s <model> <preset>`

If you pass `--profile <path>`, this mapping is bypassed.

Resolution order in `ddev slice`:

1. `--profile <path>` (explicit override)
2. Mapped `profile` file (if present)
3. Vendor preset fields (`vendor_ini` + profile names)
4. PrusaSlicer defaults
