include <settings.scad>;

wall_tickness = mouting_screw_hole_dia*2+5;

rod_mount_thickness = 6;

//y_end1();


block_length = rods_spacing+2*rods_r+2*rod_mount_thickness;
block_width = 2*rods_r+2*rod_mount_thickness+mouting_screw_hole_dia*1.5;
module y_end(with_enforcement = true)
{
    difference(){
        hull(){
            roundedRect([block_length, block_width, wall_tickness], rod_mount_thickness, $fn = 12);
            if(with_enforcement)
                translate([0,-block_width/2,wall_tickness])rotate([-90,0,0])
                    cylinder(r=screw_hole_dia, h = block_width/2+rod_mount_thickness);
        }
        {
            //rods holes
            for(mul = [-1,1])
            translate([rods_spacing/2*mul, 0,0]) {
                cylinder(r=rods_r, h=wall_tickness);
                translate([-1, rods_r-0.2,-1])
                cube([2, wall_tickness+rods_r, wall_tickness+10]);
            }
            //rods screws
            for(mul=[1,-1])
            translate([-mul*block_length/2,rods_r+4,wall_tickness/2])rotate([0,mul*90,0])
            {
                screw_hole(mouting_screw_hole_dia, rods_r*2+rod_mount_thickness+8);
                translate([0,0,rods_r*2+rod_mount_thickness+3]){
                    translate([-mouting_screw_hole_dia*0.85,0,0])cube([mouting_screw_hole_dia*1.7,block_width/2,3]);
                    rotate([0,0,30])cylinder(r=mouting_screw_hole_dia*0.95, h=3, $fn=6);
                }
            }

        }
    }
}

module y_end1()
{
    difference(){
        y_end();
        //bearing hole
        translate([0,-block_width/2,wall_tickness/2+screw_hole_dia/2]) 
        {   
            rotate([-90,0,0])screw_hole(screw_hole_dia, wall_tickness+10,true);
        
        translate([0,belt_width+block_width/2+rods_r-1,0])
            difference(){
            cube([belt_bearing_dia+10, belt_width*2, wall_tickness*2],center=true);
            //bearing support
            translate([0,-belt_width+2,0])rotate([90,0,0])
                cylinder(r=screw_hole_dia, h=2);
            }
        }   
    }
}

module y_end11()
{
    block_length = rods_spacing+2*rods_r+2*rod_mount_thickness;
    block_width = 2*rods_r+2*rod_mount_thickness+mouting_screw_hole_dia*1.5;
    difference(){
        hull(){
        roundedRect([block_length, block_width, wall_tickness], rod_mount_thickness, $fn = 12);


            translate([0,-block_width/2,wall_tickness])rotate([-90,0,0])
                cylinder(r=screw_hole_dia, h = block_width/2+rod_mount_thickness);
        }
        {
            //rods holes
            for(mul = [-1,1])
            translate([rods_spacing/2*mul, 0,0]) {
                cylinder(r=rods_r, h=wall_tickness);
                translate([-1, rods_r-0.2,-1])
                cube([2, wall_tickness+rods_r, wall_tickness+10]);
            }
            //bearing hole
            translate([0,-block_width/2,wall_tickness/2+screw_hole_dia/2]) 
            {	
                rotate([-90,0,0])screw_hole(screw_hole_dia, wall_tickness+10,true);
            
            translate([0,belt_width+block_width/2+rods_r-1,0])
                difference(){
                cube([belt_bearing_dia+10, belt_width*2, wall_tickness*2],center=true);
                //bearing support
                translate([0,-belt_width+3,0])rotate([90,0,0])
                    cylinder(r=screw_hole_dia, h=3);
                }
            }
            //rods screws
            for(mul=[1,-1])
            translate([-mul*block_length/2,rods_r+4,wall_tickness/2])rotate([0,mul*90,0])
            {
                screw_hole(mouting_screw_hole_dia, rods_r*2+rod_mount_thickness+8);
                translate([0,0,rods_r*2+rod_mount_thickness+3]){
                    translate([-mouting_screw_hole_dia*0.90,0,0])cube([mouting_screw_hole_dia*1.8,block_width/2,3]);
                    rotate([0,0,30])cylinder(r=mouting_screw_hole_dia, h=3, $fn=6);
                }
            }

        }
    }

}