// Minimal flat 2D sitting cat silhouette with facial cutouts.

include <lib/scale_overlay.scad>;

$fn = 100;

size = 60;
thickness = 2;
show_scale = false;

module cat_silhouette(size = 60) {
    head_r = size / 2;
    ear_w = size * 0.35;
    ear_h = size * 0.45;
    ear_offset_x = size * 0.28;

    body_w = size * 1.1;
    body_h = size * 1.1;
    body_cy = -size * 0.95;

    tail_len = size * 1.0;
    tail_thick = size * 0.18;

    union() {
        // Head
        circle(r = head_r);

        // Ears
        for (sx = [-1, 1])
            translate([sx * ear_offset_x, head_r * 0.6])
                polygon(points = [
                    [-ear_w / 2, 0],
                    [ ear_w / 2, 0],
                    [ 0,         ear_h],
                ]);

        // Body — wider oval below head
        translate([0, body_cy])
            scale([body_w / size, body_h / size])
                circle(r = size / 2);

        // Front paws — small bumps at the base of the body
        for (sx = [-1, 1])
            translate([sx * size * 0.32, body_cy - body_h * 0.42])
                circle(r = size * 0.18);

        // Tail — curls up on the right side of the body
        translate([size * 0.55, body_cy - size * 0.05])
            rotate(-25)
                hull() {
                    circle(r = tail_thick / 2);
                    translate([tail_len * 0.55, tail_len * 0.55])
                        circle(r = tail_thick / 2);
                }
        translate([size * 0.55 + tail_len * 0.55 * cos(-25) - tail_len * 0.55 * sin(-25),
                   body_cy - size * 0.05 + tail_len * 0.55 * sin(-25) + tail_len * 0.55 * cos(-25)])
            circle(r = tail_thick / 2);
    }
}

module cat_face_cutouts(size = 60) {
    eye_r = size * 0.07;
    eye_dx = size * 0.18;
    eye_dy = size * 0.08;

    // Eyes
    for (sx = [-1, 1])
        translate([sx * eye_dx, eye_dy])
            circle(r = eye_r);

    // Nose — small downward triangle
    nose_w = size * 0.12;
    nose_h = size * 0.09;
    translate([0, -size * 0.08])
        polygon(points = [
            [-nose_w / 2,  nose_h / 2],
            [ nose_w / 2,  nose_h / 2],
            [ 0,          -nose_h / 2],
        ]);

    // Mouth — two small arcs forming a "w"
    mouth_y = -size * 0.22;
    mouth_dx = size * 0.07;
    mouth_r = size * 0.06;
    mouth_thick = size * 0.018;
    for (sx = [-1, 1])
        translate([sx * mouth_dx, mouth_y])
            difference() {
                circle(r = mouth_r);
                circle(r = mouth_r - mouth_thick);
                translate([0, mouth_r / 2])
                    square([mouth_r * 2.2, mouth_r * 1.2], center = true);
            }

    // Whiskers — thin slits either side of the muzzle
    whisker_y_offsets = [-size * 0.15, -size * 0.20];
    whisker_len = size * 0.22;
    whisker_thick = size * 0.012;
    whisker_inner = size * 0.20;
    for (sx = [-1, 1], wy = whisker_y_offsets)
        translate([sx * (whisker_inner + whisker_len / 2), wy])
            square([whisker_len, whisker_thick], center = true);
}

module cat_model(
    size = 60,
    thickness = 2
) {
    linear_extrude(height = thickness)
        difference() {
            cat_silhouette(size = size);
            cat_face_cutouts(size = size);
        }
}

cat_model(
    size = size,
    thickness = thickness
);

if (show_scale) {
    translate([-size, -size * 1.8, 0])
        scale_overlay(length = 100, major_step = 10);
}
