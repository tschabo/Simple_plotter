include <carriage.scad>;
include <settings.scad>;
include <y_end1.scad>;
include <y_end2.scad>;
include <belt_clamp.scad>;
include <x_end.scad>;
use <pulley.scad>;
use <Belt_Generator.scad>;


for(mul = [1,-1])
    translate([0,-mul*136+80,linear_bearing_r]) scale([1,mul,1]) 
    {
        rotate([90,0,0]) x_end();
        translate([0,-35,-4]) Pulley16Teeth();
    }

translate([-base_width/2,0,0]) 
{
	carriage_assembly();
	translate([0,0, 4*linear_bearing_r])rotate([180,0,90])
	carriage_assembly();
}

translate([173,base_width/2,linear_bearing_r*3]) rotate([90,180,90])
y_end1();

translate([-114,base_width/2,linear_bearing_r*3]) 
{
	rotate([-90,0,-90]) y_end2();
	rotate([0,0,90]) translate([-clamp_width/2,1,-13]) belt_clamp();
}


module carriage_assembly()
{
	carriage();
	for(pos = [linear_bearing_r+linear_bearing_spacig/2,base_width - (linear_bearing_r+linear_bearing_spacig/2)])
	translate([pos,0,linear_bearing_r]) rotate([-90,0,0])
	{
		color([0.5,0.5,0.5]) 
		{	
			translate([0,0,-70]) 
				cylinder(r=rods_r-0.1, h=300);
			guide(true);
		}
	}
}

// belt arrangement is for preview only!
h = 11.0;
bl = 300+45;
color([0.1,0.1,0.1]){
    for(mul = [1,-1]){
        scale([mul,1,1]) translate([6,-90,h])rotate([0,0,90]) belting("straight",belt_profile, belt_length = bl, belting_width = 8 );
        translate([-115,base_width/2+mul*6,h]) scale([1,-mul,1]) belting("straight",belt_profile, belt_length = bl-40, belting_width = 8 );
    }
}