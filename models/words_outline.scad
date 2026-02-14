include <lib/scale_overlay.scad>;

$fn = 200;
name1 = "Love";
name2 = "You";
Long = 78;
text_font = "Liberation Sans:style=Bold";
show_scale = false;

ring_thickness = 1.6;
outline_thickness = 1.0;
model_height = 2.8;

module rounded_rectangle(l, w, r) {
    hull() {
        for (i = [-1, 1], j = [-1, 1]) {
            translate([i * (l / 2 - r), j * (w / 2 - r)])
                circle(r = r);
        }
    }
}

module text_outline_2d(label, size, stroke, font_name) {
    difference() {
        offset(r = stroke / 2)
            text(label, size = size, halign = "center", valign = "center", font = font_name);
        offset(r = -stroke / 2)
            text(label, size = size, halign = "center", valign = "center", font = font_name);
    }
}

module words_outline_model(
    name1 = "Love",
    name2 = "You",
    Long = 78,
    text_font = "Liberation Sans:style=Bold",
    ring_thickness = 1.6,
    outline_thickness = 1.0,
    model_height = 2.8
) {
    H = Long / 1.1612;
    inner_length = H;
    inner_width = 30;
    outer_length = inner_length + (2 * ring_thickness);
    outer_width = inner_width + (2 * ring_thickness);

    scale(1.1613) {
        linear_extrude(height = model_height) {
            union() {
                difference() {
                    rounded_rectangle(outer_length, outer_width, 3 + ring_thickness);
                    rounded_rectangle(inner_length, inner_width, 3);
                }

                translate([0, 0, 0])
                    text_outline_2d(name1, 19, outline_thickness, text_font);
                translate([0, 0, 0])
                    text_outline_2d(name2, 19, outline_thickness, text_font);
            }
        }
    }
}

words_outline_model(
    name1 = name1,
    name2 = name2,
    Long = Long,
    text_font = text_font,
    ring_thickness = ring_thickness,
    outline_thickness = outline_thickness,
    model_height = model_height
);

if (show_scale) {
    translate([-10, -22, 0])
        scale_overlay(length = 100, major_step = 10);
}
