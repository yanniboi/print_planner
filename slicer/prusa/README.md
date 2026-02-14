# PrusaSlicer Profiles

Put PrusaSlicer `.ini` config files in `slicer/prusa/profiles/`.

Default expected profile for this project:

- `slicer/prusa/profiles/anycubic_mega_s.ini`

This file is optional. If missing, `ddev slice` will try the built-in PrusaSlicer Anycubic vendor preset mapping from `config/slicer-presets.json`, then fall back to PrusaSlicer defaults.

How to create it from desktop PrusaSlicer:

1. Select your printer/profile (for example Anycubic Mega S).
2. Export config as `.ini`.
3. Save it as `slicer/prusa/profiles/anycubic_mega_s.ini`.

Then slice from CLI:

`ddev slice <model> <preset>`

Override behavior:

- Different printer key: `ddev slice --printer <key> <model> <preset>`
- Direct profile path: `ddev slice --profile path/to/profile.ini <model> <preset>`
