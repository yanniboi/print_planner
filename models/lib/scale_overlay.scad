module scale_overlay(length = 100, major_step = 10, tick_height = 2, tick_width = 0.8, base_height = 0.4) {
    color([0.1, 0.1, 0.1])
        cube([length, tick_width, base_height]);

    for (x = [0:major_step:length]) {
        color([0.1, 0.1, 0.1])
            translate([x, 0, 0])
                cube([tick_width, tick_width, tick_height]);
    }
}
