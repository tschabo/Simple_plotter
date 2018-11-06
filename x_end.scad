include <settings.scad>;
include <y_end1.scad>;

motor_mount_thickness = 6;
motor_mount_support_thickness = 4;
threaded_rods_r = 5.1;

nema17_width = 43;
nema17_center_hole_r = 24.5/2;
nema17_mount_hole_r = 3.5/2;
nema17_mount_holes_spacing = 31.2;
mount_width = nema17_width+3;

//x_end();


module x_end() {
    difference()
    {
        y_end(false);
        //belt hole
        translate([0,-block_width/2,wall_tickness/2+screw_hole_dia/2]) 
        {  
            translate([0,belt_width+block_width/2+rods_r-1,0])
            
            cube([belt_bearing_dia+10, belt_width*2, wall_tickness*2],center=true);
            
        }   
    }
    //motor mount
    translate([0,3,wall_tickness])
    rotate([90,0,0]) 
    {
        motor_mount(motor_mount_thickness);
        // motor mount supports
        for(mul = [1,-1])
        translate([mul * (mount_width/2 + motor_mount_support_thickness/2-1),0,0]) rotate([0,-90,0])
        linear_extrude(height = motor_mount_support_thickness, center = true, convexity = 10, twist = 0)
            polygon(points=[[0,0],[mount_width/1.5,0],[motor_mount_thickness,mount_width/1.5],[0,mount_width/1.5]], paths=[[0,1,2,3]]);
    }
    //main block
    translate([-block_length/2, -nema17_motor_length-rods_r, 0])
    {    
        difference()
        {
            //threaded rods holes
            cube([block_length, nema17_motor_length, wall_tickness]);
            translate([block_length/2,threaded_rods_r*2,0])
            {
                translate([0, nema17_motor_length/2-threaded_rods_r, 0]) 
                    cylinder(r=nema17_motor_length/3, h=wall_tickness);
                for(mul = [1,-1])
                translate([mul*(block_length/2-threaded_rods_r*2),0,0])
                cylinder(r=threaded_rods_r, h=wall_tickness);
            }
        }
    }
    //legs
    for(mul = [1,-1])
        translate([mul*(block_length/2+mouting_screw_hole_dia*2),-mount_width-rods_r-4,0])
            scale([-mul,1,1]) 
            difference()
            {
                leg_width = 30;
                leg_height = 8;
                cube([leg_width,leg_height,wall_tickness]);
                {
                    translate([leg_width,-3,0]) cylinder(r=leg_height, h=wall_tickness);
                    translate([mouting_screw_hole_dia,leg_height+1,wall_tickness/2]) 
                    rotate([90,0,0]) 
                        screw_hole(mouting_screw_hole_dia, leg_height+10,true);
                }
            }
    
}

module motor_mount(mount_height=5)
{
    translate([0,mount_width/2,0])
    difference()
    {
        translate([-mount_width/2,-mount_width/2,0])
        {
            //one side rounded corners block
            hull(){
                round_r = 8;
                for(xpos = [round_r, mount_width-round_r])
                    translate([xpos,mount_width-round_r+2,0]) 
                        cylinder(r=round_r, h=mount_height);
                cube([mount_width,mount_width/2,mount_height]);
            }
        }
        //main hole
        hull()
        {
            for(offset = [0,3])
                translate([0,offset,0]) 
                cylinder(r=nema17_center_hole_r, h=mount_height);
        }
        //screws holes
        for(pos = [[1,1,0],[-1,1,0],[1,-1,0],[-1,-1,0]])
            translate(nema17_mount_holes_spacing/2*pos)
                hull(){
                    for(offset = [0,3])
                        translate([0,offset,0]) 
                        cylinder(r=nema17_mount_hole_r, h=10, $fn=8);
                }
    }
}