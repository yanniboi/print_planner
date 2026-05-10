// Minimal flat 2D side-profile squirrel silhouette with face cutout.

include <lib/scale_overlay.scad>;

$fn = 80;

size = 25;
thickness = 2;
show_scale = false;

module squirrel_silhouette(size = 25) {
    body_w   = size * 0.55;
    body_h   = size * 0.85;

    head_r   = size * 0.32;
    head_cx  = size * 0.18;
    head_cy  = size * 0.55;

    snout_r  = size * 0.13;
    snout_cx = head_cx + head_r * 0.90;
    snout_cy = head_cy - head_r * 0.35;

    ear_w    = size * 0.18;
    ear_h    = size * 0.22;
    ear_cx   = head_cx - size * 0.04;
    ear_cy   = head_cy + head_r * 0.60;

    foot_w   = size * 0.55;
    foot_h   = size * 0.18;
    foot_cx  = size * 0.12;
    foot_cy  = -body_h / 2 + size * 0.01;

    paw_r    = size * 0.09;
    paw_cx   = head_cx + head_r * 0.50;
    paw_cy   = head_cy - head_r * 1.30;

    acorn_r  = size * 0.08;
    acorn_cx = paw_cx + paw_r * 1.00;
    acorn_cy = paw_cy + paw_r * 0.10;

    // Tail — chain of circles hulled together along a curl
    // Each row: [x, y, radius]
    tail_pts = [
        [-size * 0.20, -size * 0.32, size * 0.12],
        [-size * 0.65, -size * 0.10, size * 0.20],
        [-size * 0.95,  size * 0.30, size * 0.25],
        [-size * 0.95,  size * 0.80, size * 0.27],
        [-size * 0.55,  size * 1.20, size * 0.25],
        [-size * 0.10,  size * 1.40, size * 0.20],
        [ size * 0.10,  size * 1.32, size * 0.10],
        [ size * 0.28,  size * 1.22, size * 0.02],
    ];

    union() {
        // Body
        scale([body_w / size, body_h / size])
            circle(r = size / 2);

        // Head
        translate([head_cx, head_cy])
            circle(r = head_r);

        // Snout
        translate([snout_cx, snout_cy])
            circle(r = snout_r);

        // Ear
        translate([ear_cx, ear_cy])
            polygon(points = [
                [-ear_w / 2, 0],
                [ ear_w / 2, 0],
                [ 0,         ear_h],
            ]);

        // Hind foot
        translate([foot_cx, foot_cy])
            scale([foot_w / size, foot_h / size])
                circle(r = size / 2);

        // Front paw
        translate([paw_cx, paw_cy])
            circle(r = paw_r);

        // Acorn body
        translate([acorn_cx, acorn_cy])
            circle(r = acorn_r);
        // Acorn cap
        translate([acorn_cx, acorn_cy + acorn_r * 0.7])
            scale([1.15, 0.55])
                circle(r = acorn_r);

        // Tail — hulled segments
        for (i = [0 : len(tail_pts) - 2])
            hull() {
                translate([tail_pts[i][0],     tail_pts[i][1]])
                    circle(r = tail_pts[i][2]);
                translate([tail_pts[i + 1][0], tail_pts[i + 1][1]])
                    circle(r = tail_pts[i + 1][2]);
            }
    }
}

module squirrel_face_cutouts(size = 25) {
    head_cx = size * 0.18;
    head_cy = size * 0.55;

    // Eye
    translate([head_cx + size * 0.10, head_cy + size * 0.05])
        circle(r = size * 0.045);
}

module squirrel_model(
    size = 25,
    thickness = 2
) {
    linear_extrude(height = thickness)
        difference() {
            squirrel_silhouette(size = size);
            squirrel_face_cutouts(size = size);
        }
}

squirrel_model(
    size = size,
    thickness = thickness
);

if (show_scale) {
    translate([-size, -size * 1.3, 0])
        scale_overlay(length = 100, major_step = 10);
}
