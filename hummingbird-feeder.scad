// ----------------------
// Hummingbird Perch Ring
// ----------------------

// ===== PARAMETERS =====
inner_diameter = 63;      // mm — feeder diameter
ring_thickness = 3.5;     // radial thickness
ring_height    = 5;       // vertical thickness

perch_count = 3;

// Round perch sizing
perch_d   = 3.0;          // mm perch diameter (matches your 2.5–3mm measurement)
perch_out = 35;            // mm how far it sticks OUTSIDE the ring

cross_perch_enable = true;
cross_perch_length = 22;  // mm total cross bar length (side-to-side)
cross_d = perch_d;        // cross bar diameter (keep same as perch)

// ===== DERIVED =====
outer_diameter = inner_diameter + ring_thickness * 2;
radius = inner_diameter / 2;

// ===== RING =====
difference() {
    cylinder(h=ring_height, d=outer_diameter, $fn=200);
    translate([0,0,-1])
        cylinder(h=ring_height+2, d=inner_diameter, $fn=200);
}

// ===== PERCHES =====
for (i = [0 : perch_count-1]) {
    angle = 360 / perch_count * i;

    rotate([0,0,angle])
    translate([radius + ring_thickness/2 + perch_out/2, 0, ring_height/2]) {

        // Main perch (only the portion outside the ring)
        rotate([0,90,0])
            cylinder(h=perch_out, d=perch_d, $fn=32, center=true);

        // Cross-perch at the outer end of the main perch
        if (cross_perch_enable) {
            translate([perch_out/2, 0, 0])
            rotate([90,0,0])
                cylinder(h=cross_perch_length, d=cross_d, $fn=32, center=true);
        }
    }
}
