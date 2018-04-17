// Eurorack constants
u = 44.466666667;
hp = 5.08;
panel_thickness = 3;
rail_depth = 6;

// Fixing holes
module fixinghole() {
    hull() {
        translate([-0.5*hp,0]) cylinder(h = 100, d=3, center = true, $fn=100);
        translate([0.5*hp,0]) cylinder(h = 100, d=3, center = true, $fn=100);
    }   
}

// IDC socket
module idcsocket () {
    // 10-way
    idc_x = 9;
    idc_y = 20;
    cube(size=[idc_x,idc_y,10]);
}

// Jack socket
module jacksocket() {
    cylinder(h = 100, d=6, center = true, $fn=100);
}

// Backshell
monotron_x = 120;
monotron_y = 71;
monotron_z = 16;
monotron_padding = 3;
backbox_x = monotron_x+(panel_thickness*2)+(monotron_padding*2);
backbox_y = monotron_y+(panel_thickness*2)+(monotron_padding*2);
backbox_z = monotron_z;
// Hole
cutout_x = monotron_x + 2*monotron_padding;
cutout_y = monotron_y + 2*monotron_padding;
cutout_z = monotron_z;

top_row_y = (3*u)-15;
bottom_row_y = (3*u)-30;

difference() {
    group() {
        // Front panel
        translate([-15*hp,0,-panel_thickness]) {
            color("darkblue") cube(size=[30*hp, 3*u, panel_thickness]);
        }
        // Back box
        translate([-backbox_x/2-8,rail_depth+monotron_padding,-panel_thickness-backbox_z]) {
            color("white") cube(size=[backbox_x, backbox_y, backbox_z]);
        }
    }
    // Monotron slot
    translate([-cutout_x/2 - 8,rail_depth+monotron_padding+panel_thickness,-monotron_z]) {
        cube(size=[cutout_x, cutout_y, cutout_z+1]);
    }
    // Fixing holes
    group () {
        translate([13*hp,rail_depth/2]) fixinghole();
        translate([0,rail_depth/2]) fixinghole();
        translate([-13*hp,rail_depth/2]) fixinghole();
        translate([13*hp,3*u-(rail_depth/2)]) fixinghole();
        translate([0,3*u-(rail_depth/2)]) fixinghole();
        translate([-13*hp,3*u-(rail_depth/2)]) fixinghole();
    }
    // IDC socket
    translate([12*hp,60,-5]) idcsocket();
    // Jack sockets
    group () {
        // audio in
        translate([-12*hp,top_row_y,-5]) jacksocket();
        // pitch
        translate([-8*hp,top_row_y,-5]) jacksocket();
        // cutoff
        translate([-4*hp,top_row_y,-5]) jacksocket();
        // vco out
        translate([8*hp,top_row_y,-5]) jacksocket();
        // audio out
        translate([12*hp,top_row_y,-5]) jacksocket();
        // gate
        translate([-8*hp,bottom_row_y,-5]) jacksocket();
        // lfo rate
        translate([-4*hp,bottom_row_y,-5]) jacksocket();
        // lfo out
        translate([8*hp,bottom_row_y,-5]) jacksocket();
    }
}