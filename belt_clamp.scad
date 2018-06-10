include <settings.scad>;
include <carriage.scad>;
include <Belt_Generator.scad>;

//belt_clamp();

clamp_height = belt_width + 2;
clamp_width = rods_spacing/1.6;

module belt_clamp()
{
    difference()
    {
        hull()
        {
            cube([clamp_width, 3, clamp_height]);
            translate([clamp_width/2-mouting_screw_hole_dia/2,0,0]) 
                cube([mouting_screw_hole_dia, mouting_screw_hole_dia+3, clamp_height]);
        }
        translate([clamp_width/2,mouting_screw_hole_dia+3,clamp_height/2]) 
            rotate([90,0,0]) screw_hole(mouting_screw_hole_dia, 30, true);
        scale([1,1.3,1])
        belting("straight",belt_profile, belt_length = clamp_width, belting_width = clamp_height );
    }
    
}
 
