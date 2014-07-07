clamp_depth = 40;
pocket_depth = 70;
pocket_width = 59;
pocket_thickness = 19;

wall_thickness = 2;

pocket_outer_depth = pocket_depth + wall_thickness;
pocket_outer_width = pocket_width + wall_thickness * 2;
pocket_outer_thickness = pocket_thickness + wall_thickness * 2;

arm_length = 30;

clearance = 0.3;

rail_inner_width = pocket_outer_width / 3 + clearance * 2;
rail_outer_width = rail_inner_width + wall_thickness * 2;

rail_inner_thickness = wall_thickness + clearance * 2;
rail_outer_thickness = rail_inner_thickness + wall_thickness;

rail_flange_width = wall_thickness * 2;
rail_opening = rail_outer_width - rail_flange_width * 3;

module pocket () {
    difference () {
        translate ([-pocket_outer_width / 2, -pocket_outer_thickness / 2, 0])
        cube ([pocket_outer_width, pocket_outer_thickness,
                pocket_outer_depth]);

        translate ([-pocket_width / 2, -pocket_thickness / 2,  wall_thickness])
        cube ([pocket_width, pocket_thickness, pocket_depth + 0.1]);
    }
}

module upper_arms () {
    translate ([-pocket_outer_width / 2, 0, 0])
    difference () {
        cube ([pocket_outer_width, arm_length, wall_thickness]);

        translate ([pocket_outer_width / 3, -0.1, -0.1])
        cube ([pocket_outer_width / 3, arm_length + 0.2, wall_thickness + 0.2]);
    }
}

module rail () {
    difference () {
        // block forming the rail
        translate ([-rail_outer_width / 2, 0, 0])
        cube ([rail_outer_width, rail_outer_thickness, pocket_outer_depth]);

        // carve out the track
        translate ([-rail_inner_width / 2, -0.1, -0.1])
        cube ([rail_inner_width, rail_inner_thickness + 0.1,
                pocket_outer_depth + 0.2]);

        // carve out the opening
        translate ([-rail_opening / 2, 0, -0.1])
        cube ([rail_opening, rail_outer_thickness + 0.1,
                pocket_outer_depth + 0.2]);
    }
}

pocket ();

translate ([0, pocket_outer_thickness / 2, pocket_depth])
upper_arms ();

translate ([0, pocket_outer_thickness / 2 - 0.1, 0])
rail ();
