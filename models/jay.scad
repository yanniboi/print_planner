// Small flat letter "J" — a quick test print.

include <lib/scale_overlay.scad>;

$fn = 100;

letter = "J";
size = 30;
thickness = 2;
text_font = "Liberation Sans:style=Bold";
show_scale = false;

module jay_model(
    letter = "J",
    size = 30,
    thickness = 2,
    text_font = "Liberation Sans:style=Bold"
) {
    linear_extrude(height = thickness)
        text(letter, size = size, halign = "center", valign = "center", font = text_font);
}

jay_model(
    letter = letter,
    size = size,
    thickness = thickness,
    text_font = text_font
);

if (show_scale) {
    translate([-size, -size * 0.8, 0])
        scale_overlay(length = 100, major_step = 10);
}
