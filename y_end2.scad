include <settings.scad>;
include <y_end1.scad>;
include <Belt_Generator.scad>;

//y_end2();

tool_mount_holes_spacing = 40;

module y_end2()
{
    difference(){
        y_end(false);
        //belt clamp screw hole
        translate([0,block_width/2-mouting_screw_hole_dia-1,wall_tickness]) 
            scale([1,1,-1]) screw_hole(mouting_screw_hole_dia, wall_tickness);
        //belt groove
        translate([0,-block_width/2, 0]) 
        {   
            for(mul = [-1,1])
            translate([(belt_bearing_dia/2+1)*mul,rods_r+block_width/2-1,wall_tickness])
            {
                //groove round
                translate([mul*1,0,-wall_tickness])rotate([-90,0,0]) 
                    scale([mul,1,1])cylinder(r=1.7, h= wall_tickness, $fn = 4);
                //cube([4,4,wall_tickness]);
                //cube([belt_bearing_dia+10, belt_width*2, wall_tickness*2],center=true);
                rotate([0,90,90]) scale([1,1.3*mul,1])
                    belting("straight",belt_profile, belt_length = 50, belting_width = belt_width+2 );
            }
            //tool mount screw holes
            for(mul = [1,-1])
            translate([mul*tool_mount_holes_spacing/2,mouting_screw_hole_dia*2,wall_tickness])
                    scale([1,1,-1])
                        screw_hole(mouting_screw_hole_dia, wall_tickness,true);
        }   
    }
}
