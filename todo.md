# TODO

## Autosize scale overlay in previews

- Add optional `scale_mode` OpenSCAD variable (`"fixed"` or `"auto"`) with default `"fixed"`.
- In auto mode, compute a reference length from model bounds and snap to a readable size (for example: 20, 50, 100, 150, 200 mm).
- Keep major ticks at 10 mm or 20 mm depending on chosen ruler length.
- Keep overlay placement consistent near a corner while avoiding overlap with the model silhouette.
- Preserve current behavior: exports always force `show_scale=false`.
- Add CLI flag to preview command for future toggle (for example `--scale-mode auto`) once implemented.

## Multi-angle previews

- Add `ddev preview-multi <model> <preset>` to render multiple PNG angles in one command.
- Load angle list from `config/camera-presets.json` so adding/removing views requires no command-script changes.
- Use filename suffixes like `build/png/<model>-<preset>-<camera>.png`.
