// Simple parametric open-top box for CLI render/export testing.

include <lib/scale_overlay.scad>;

width = 80;
depth = 60;
height = 30;
wall_thickness = 2.4;
floor_thickness = 2.4;
show_scale = false;

module box_model(
    width = 80,
    depth = 60,
    height = 30,
    wall_thickness = 2.4,
    floor_thickness = 2.4
) {
    inner_width = width - (2 * wall_thickness);
    inner_depth = depth - (2 * wall_thickness);
    inner_height = height - floor_thickness;

    difference() {
        cube([width, depth, height]);
        translate([wall_thickness, wall_thickness, floor_thickness])
            cube([inner_width, inner_depth, inner_height]);
    }
}

box_model(
    width = width,
    depth = depth,
    height = height,
    wall_thickness = wall_thickness,
    floor_thickness = floor_thickness
);

if (show_scale) {
    // Place ruler near front-left corner for visual size reference in previews.
    translate([-10, -8, 0])
        scale_overlay(length = 100, major_step = 10);
}
