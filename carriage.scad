include <settings.scad>;
;

// print BOTH! versions
//carriage(true);
//carriage(false);

module carriage(generate_nut_holes=true)
{
    switch_holes_spacing = [0,6.5,9.5];
    
    difference()
    {
        union(){
            carriage_base(generate_nut_holes);
            //endstop support
            translate([2*linear_bearing_r+linear_bearing_spacig,0,0]) 
                cube([switch_holes_spacing[2]-linear_bearing_spacig/2+2.5,linear_bearing_spacig,base_height]);
        }
        //endstop holes
        for(spacing = switch_holes_spacing)
        translate([2*linear_bearing_r+linear_bearing_spacig/2+spacing,3,0]) cylinder( r=1.1, h=base_height);
    }
}

module carriage_base(generate_nut_holes=true)
{
    offset1 = base_width/2-belt_bearing_dia-1;
    offset2 = base_width/2+belt_bearing_dia+1;
    bearing_holes = [[offset1, offset1 ,0], [offset1, offset2, 0],[offset2, offset1 ,0], [offset2, offset2, 0]];

    difference()
    {	
        union()
        {
            cube([base_width, base_width, base_height]);
            //belt bearing support
            for(pos = bearing_holes) translate(pos) cylinder(r=screw_hole_dia*1.2, h=(linear_bearing_r*4-belt_bearing_height)/2-0.5 );
        
            //linear bearing support
            offset = (2*linear_bearing_r+linear_bearing_spacig/2);
            for(pos = [[offset,linear_bearing_spacig,0],
                [base_width-offset-linear_bearing_r,linear_bearing_spacig,0],
                [base_width-offset-linear_bearing_r,base_width-linear_bearing_spacig-linear_bearing_r,0],
                [offset,base_width-linear_bearing_spacig-linear_bearing_r,0]])
                    translate(pos)
                    cube([linear_bearing_r,linear_bearing_r,linear_bearing_r*2-0.2]);
        }

        for(pos = [linear_bearing_r+linear_bearing_spacig/2,base_width - (linear_bearing_r+linear_bearing_spacig/2)])
        translate([pos,0,linear_bearing_r]) rotate([-90,0,0])guide();
        //belt bearings screw holes	
        for(pos = bearing_holes)
            translate(pos)
                screw_hole(screw_hole_dia, base_height*2,, generate_nut_holes);
        //mounting holes
        offset12 = linear_bearing_r*2+linear_bearing_spacig;
        offset22 = base_width-offset12;
        mounting_holes = [[offset12, offset12 ,0], [offset12, offset22, 0],[offset22, offset12 ,0], [offset22, offset22, 0]]
    ;
        for(pos = mounting_holes)
            translate(pos)
                screw_hole(mouting_screw_hole_dia, base_height*2, generate_nut_holes);
        //center hole
        translate([base_width/2, base_width/2,0]) cylinder(r=belt_bearing_dia, h=base_height);
        //material saving cuts
        for(xpos=[0,base_width])
            translate([base_width/2,xpos,0]) cylinder(r=(base_width-linear_bearing_spacig*2-linear_bearing_r*4)/2, h=linear_bearing_r*2);
    }
}


module guide(bearings_only=false)
{
	if(!bearings_only)
        cylinder(r = rods_r+0.6, h = base_width );
	for(pos = [linear_bearing_spacig, base_width-linear_bearing_spacig-linear_bearing_l])
	translate([0,0,pos]){
		if(!bearings_only)
            translate([-linear_bearing_r/2,linear_bearing_r/2,0])cube([linear_bearing_r, linear_bearing_r, linear_bearing_l]);
		cylinder(r = linear_bearing_r, h = linear_bearing_l );
	}
	
}