include <lib/scale_overlay.scad>;

$fn = 300;
name1 = "Love";
name2 = "You";
Long = 78;
text_font = "Liberation Sans:style=Bold";
show_scale = false;

module rounded_rectangle(l, w, r) {
    hull() {
        for (i = [-1, 1], j = [-1, 1])
            translate([i * (l / 2 - r), j * (w / 2 - r)])
                circle(r);
    }
}

module words_model(name1 = "Love", name2 = "You", Long = 78, text_font = "Liberation Sans:style=Bold") {
    H = Long / 1.1612;

    scale(1.1613) {
        difference() {
            difference() {
                for (z = [-100:100]) {
                    translate([1.744 * z, 0, 0])
                        rotate(a = [0, 30, 0])
                            cube([0.5, 30, 6], center = true);
                }
                for (z = [-100:100]) {
                    translate([1.744 * z, 0, 0])
                        rotate(a = [0, -30, 0])
                            cube([1, 30, 6], center = true);
                }

                difference() {
                    translate([0, 0, -2.725])
                        linear_extrude(height = 5.45)
                            rounded_rectangle(500, 32, 3);
                    translate([0, 0, -2.725])
                        linear_extrude(height = 5.45)
                            rounded_rectangle(H, 30, 3);
                }
            }
            translate([0, 0, -2.725])
                linear_extrude(height = 1.96)
                    rounded_rectangle(H, 31, 3);
            translate([0, 0, 2.28])
                linear_extrude(height = 1.96)
                    rounded_rectangle(H, 31, 3);
        }

        difference() {
            translate([0, 0, -0.765])
                linear_extrude(height = 3.1)
                    rounded_rectangle(H + 2.6, 32.6, 3);
            translate([0, 0, -0.765])
                linear_extrude(height = 3.1)
                    rounded_rectangle(H, 30, 3);
        }

        difference() {
            translate([0, 0, -0.765])
                linear_extrude(1.5)
                    text(name1, 19, halign = "center", valign = "center", font = text_font);
            for (z = [-100:100]) {
                translate([1.744 * z, 0, 0])
                    rotate(a = [0, -30, 0])
                        cube([1, 30, 6], center = true);
            }
        }

        difference() {
            translate([0, 0, -0.765])
                linear_extrude(1.5)
                    text(name2, 19, halign = "center", valign = "center", font = text_font);
            translate([0.89, 0, 0])
                for (z = [-100:100]) {
                    translate([1.744 * z, 0, 0])
                        rotate(a = [0, 30, 0])
                            cube([1, 30, 6], center = true);
                }
        }

        for (z = [0:7]) {
            translate([0, -15 + 4.2857 * z, 0.785])
                cube([H + 1, 0.5, 3.1], center = true);
        }
    }
}

words_model(name1 = name1, name2 = name2, Long = Long, text_font = text_font);

if (show_scale) {
    translate([-10, -22, 0])
        scale_overlay(length = 100, major_step = 10);
}
